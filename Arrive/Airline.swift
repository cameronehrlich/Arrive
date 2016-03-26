//
//  Airline.swift
//  
//
//  Created by Cameron Ehrlich on 3/26/16.
//
//

import Foundation
import CoreData
import SwiftyJSON

class Airline: NSManagedObject {

    func refreshFromJSON(json: JSON) -> Void {
        
        airlineCode = json.dictionaryValue["fs"]?.string
        name = json.dictionaryValue["name"]?.string
        phoneNumber = json.dictionaryValue["phoneNumber"]?.string
        
    }

}
