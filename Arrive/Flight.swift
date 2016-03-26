//
//  Flight.swift
//
//
//  Created by Cameron Ehrlich on 3/24/16.
//
//

import Foundation
import CoreData
import SwiftyJSON

class Flight: NSManagedObject {
    
    func refreshFromJSON(json: JSON) -> Void {
        
        flightId = json.dictionaryValue["flightId"]?.number?.stringValue
        flightNumber = json.dictionaryValue["flightNumber"]?.string
        carrierCode = json.dictionaryValue["carrierFsCode"]?.string
        
        departureAirportCode = json.dictionaryValue["departureAirportFsCode"]?.string
        arrivalAirportCode  = json.dictionaryValue["arrivalAirportFsCode"]?.string
        
        let departureDateString = json["departureDate", "dateLocal"].string
        departureDate = RemoteManager.dateFromString(departureDateString)
        
        let arrivalDateString = json["arrivalDate", "dateLocal"].string
        arrivalDate = RemoteManager.dateFromString(arrivalDateString)
    }
}
