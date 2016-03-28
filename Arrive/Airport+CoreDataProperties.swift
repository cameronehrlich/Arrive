//
//  Airport+CoreDataProperties.swift
//  
//
//  Created by Cameron Ehrlich on 3/28/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Airport {

    @NSManaged var airportCode: String?
    @NSManaged var autocomplete: NSNumber?
    @NSManaged var city: String?
    @NSManaged var cityCode: String?
    @NSManaged var classification: NSNumber?
    @NSManaged var countryCode: String?
    @NSManaged var countryName: String?
    @NSManaged var elevationFeet: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var localTime: NSDate?
    @NSManaged var longitude: NSNumber?
    @NSManaged var name: String?
    @NSManaged var postalCode: String?
    @NSManaged var regionName: String?
    @NSManaged var sortOrder: NSNumber?
    @NSManaged var stateCode: String?
    @NSManaged var streetAddress: String?
    @NSManaged var timeZoneRegionName: String?
    @NSManaged var utcOffsetHours: NSNumber?
    @NSManaged var weatherUrl: String?
}
