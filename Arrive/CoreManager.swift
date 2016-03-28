//
//  CoreManager.swift
//  Arrive
//
//  Created by Cameron Ehrlich on 3/24/16.
//  Copyright © 2016 Skurt. All rights reserved.
//

import Foundation
import MagicalRecord
import Alamofire
import SwiftyJSON

class CoreManager {
    
    static let sharedManager = CoreManager() // Singletons are SOOO much cleaner in Swift! Wow!
    
    private init() {
        self.setup()
    }
    
    internal func setup() -> Void {
        MagicalRecord.setupCoreDataStackWithInMemoryStore();
    }
    
    // Mark: - Airports
    internal func fetchAirports(query: String) -> Request {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let request = RemoteManager.sharedManager.fetchAirports(query, completion: { (jsonResponse, error) in

            if let airports = jsonResponse?["response", "airports"] {
                for (index, subJson) in airports {
                    let newAirport = Airport.MR_createEntity()
                    newAirport?.refreshFromJSON(subJson, fromSearch: true, index: Int(index)!)
                }
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
        
        return request
    }
    
    internal func resetAirports() -> Void {
        Airport.MR_truncateAll()
    }
    
    internal func airportSearchFetchedResultsController() -> NSFetchedResultsController {
        let predicate = NSPredicate(format: "autocomplete = true")
        let controller: NSFetchedResultsController = Airport.MR_fetchAllSortedBy("sortOrder", ascending: true, withPredicate: predicate, groupBy: nil, delegate: nil)
        return controller
    }
    
    // Mark: - Flights
    internal func fetchDepartures(airlineCode: String, departureDate: NSDate) -> Request {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true

        let request = RemoteManager.sharedManager.fetchFlights(airlineCode, date: departureDate) { (jsonResponse, error) in
            
            // Parse Airlines
            if let airlines = jsonResponse?["appendix", "airlines"] {
                for (_, subJson) in airlines {
                    let newAirline = Airline.MR_createEntity()
                    newAirline?.refreshFromJSON(subJson)
                }
            }
            
            // Parse Airports
            if let airports = jsonResponse?["appendix", "airports"] {
                for (_, subJson) in airports {
                    let newAirport = Airport.MR_createEntity()
                    newAirport?.refreshFromJSON(subJson)
                }
            }
            
            // Parse Flights
            if let flights = jsonResponse?["flightStatuses"] {
                for (_, subJson) in flights {
                    let newFlight = Flight.MR_createEntity()
                    newFlight?.refreshFromJSON(subJson)
                }
            }

            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

        }
        
        return request
    }
    
    internal func resetFlights() -> Void {
        Flight.MR_truncateAll()
    }
    
    internal func flightsFetchedResultsController() -> NSFetchedResultsController {
        let controller: NSFetchedResultsController = Flight.MR_fetchAllSortedBy("departureDate", ascending: true, withPredicate: nil, groupBy: nil, delegate: nil)
        return controller
    }
}