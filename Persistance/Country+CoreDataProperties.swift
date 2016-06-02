//
//  Country+CoreDataProperties.swift
//  iOSPersistance
//
//  Created by Thomas Attermann on 30/05/2016.
//  Copyright © 2016 Thomas Attermann. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Country {

    @NSManaged var name: String?
    @NSManaged var belongsTo: Continent?

}
