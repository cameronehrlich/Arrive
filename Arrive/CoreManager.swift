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
    
    internal func fetchAirports(query: String) -> Request {
        
        let request = RemoteManager.sharedManager.fetchAirports(query, completion: { (jsonResponse, error) in

            if let airports = jsonResponse?["response", "airports"] {
                for (_, subJson) in airports {
                    let newAirport = Airport.MR_createEntity()
                    newAirport?.refreshFromJSON(subJson, fromSearch: true)
                }
            }
        })
        
        return request
    }
    
    internal func fetchDepartures(airlineCode: String, departureDate: NSDate) -> Request {
        
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
        }
        
        return request
    }
}