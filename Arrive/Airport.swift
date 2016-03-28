//
//  Airport.swift
//
//
//  Created by Cameron Ehrlich on 3/26/16.
//
//

import Foundation
import CoreData
import SwiftyJSON

class Airport: NSManagedObject {
    
    func refreshFromJSON(json: JSON) -> Void {
        self.refreshFromJSON(json, fromSearch: false, index: 0)
    }
    
    func refreshFromJSON(json: JSON, fromSearch: Bool, index: Int) -> Void {
    
        // Parse responses separatley depending on which API I am receiving Airport data from
        if !fromSearch {
            
            autocomplete = NSNumber(bool: false) // Came from FlightStatus API
            
            airportCode = json.dictionaryValue["fs"]?.string
            name = json.dictionaryValue["name"]?.string
            city = json.dictionaryValue["city"]?.string
            cityCode = json.dictionaryValue["cityCode"]?.string
            stateCode = json.dictionaryValue["stateCode"]?.string
            postalCode = json.dictionaryValue["postalCode"]?.string
            countryCode = json.dictionaryValue["countryCode"]?.string
            countryName = json.dictionaryValue["countryName"]?.string
            regionName = json.dictionaryValue["regionName"]?.string
            timeZoneRegionName = json.dictionaryValue["timeZoneRegionName"]?.string
            weatherUrl = json.dictionaryValue["weatherUrl"]?.string
            streetAddress = json.dictionaryValue["streetAddress"]?.string
            
            utcOffsetHours = json.dictionaryValue["utcOffsetHours"]?.number
            latitude = json.dictionaryValue["latitude"]?.number
            longitude = json.dictionaryValue["longitude"]?.number
            elevationFeet = json.dictionaryValue["elevationFeet"]?.number
            classification = json.dictionaryValue["classification"]?.number
            
            let localTimeString = json.dictionaryValue["localTime"]?.string
            localTime = RemoteManager.dateFromString(localTimeString)
    
        }
        else {
            
            autocomplete = NSNumber(bool: true) // Came from IATACodes autocomplete API
            
            airportCode = json.dictionaryValue["city_code"]?.string
            name = json.dictionaryValue["name"]?.string
            
            city = json.dictionaryValue["city_name"]?.string
            countryCode = json.dictionaryValue["country_code"]?.string
            countryName = json.dictionaryValue["country_name"]?.string
            timeZoneRegionName = json.dictionaryValue["timezone"]?.string
            
            latitude = json.dictionaryValue["lat"]?.number
            longitude = json.dictionaryValue["lng"]?.number
            sortOrder = index
        }
    }
    
}
