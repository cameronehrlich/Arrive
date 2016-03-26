//
//  Flight+CoreDataProperties.swift
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

extension Flight {

    @NSManaged var arrivalAirportCode: String?
    @NSManaged var arrivalDate: NSDate?
    @NSManaged var carrierCode: String?
    @NSManaged var departureAirportCode: String?
    @NSManaged var departureDate: NSDate?
    @NSManaged var flightId: String?
    @NSManaged var flightNumber: String?

}
