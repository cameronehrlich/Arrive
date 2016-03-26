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
    
    internal func fetchDepartures(airlineCode: String, departureDate: NSDate) -> Void {
        
        RemoteManager.sharedManager.fetchFlights(airlineCode, date: departureDate) { (jsonResponse, error) in
            
            if (error != nil) {
                print("Error: \(error.debugDescription)")
                return
            }
            
            if let flights = jsonResponse?["flightStatuses"] {
                
                for (_, subJson):(String, JSON) in flights {
                    let newFlight = Flight.MR_createEntity()
                    newFlight?.refreshFromJSON(subJson)
                }
            }
            
            print("\(Flight.MR_findAll())")
        }
    }
}