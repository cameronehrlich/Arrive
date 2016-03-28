//
//  Airport+CoreDataProperties.swift
//  
//
//  Created by Cameron Ehrlich on 3/26/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Airport {

    @NSManaged var airportCode: String?
    @NSManaged var name: String?
    @NSManaged var city: String?
    @NSManaged var cityCode: String?
    @NSManaged var stateCode: String?
    @NSManaged var postalCode: String?
    @NSManaged var countryCode: String?
    @NSManaged var countryName: String?
    @NSManaged var regionName: String?
    @NSManaged var timeZoneRegionName: String?
    @NSManaged var localTime: NSDate?
    @NSManaged var utcOffsetHours: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var longitude: NSNumber?
    @NSManaged var elevationFeet: NSNumber?
    @NSManaged var classification: NSNumber?
    @NSManaged var weatherUrl: String?
    @NSManaged var streetAddress: String?
    @NSManaged var autocomplete: NSNumber?
    @NSManaged var sortOrder: NSNumber?

}
