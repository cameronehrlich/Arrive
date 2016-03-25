//
//  Flight+CoreDataProperties.swift
//  
//
//  Created by Cameron Ehrlich on 3/24/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flight {

    @NSManaged var flightId: String?
    @NSManaged var flightNumber: String?
    @NSManaged var departureDate: NSDate?
    @NSManaged var arrivalDate: NSDate?
    @NSManaged var departureAirportCode: String?
    @NSManaged var arrivalAirportCode: String?
    @NSManaged var carrierCode: String?

}
