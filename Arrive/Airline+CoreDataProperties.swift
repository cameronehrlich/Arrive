//
//  Airline+CoreDataProperties.swift
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

extension Airline {

    @NSManaged var airlineCode: String?
    @NSManaged var name: String?
    @NSManaged var phoneNumber: String?

}
