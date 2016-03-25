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

class CoreManager {
    
    static let sharedManager = CoreManager() // Singletons are SOOO much cleaner in Swift! Wow!
    
    private init() {
        self.setup()
    }
    
    internal func setup() -> Void {
        MagicalRecord.setupCoreDataStackWithInMemoryStore();
        self.fetchTestAirport()
    }
    
    internal func fetchTestAirport() -> Void {
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    }
}