//
//  Spell+CoreDataProperties.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/27/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Spell {
    @NSManaged var name: String?
    @NSManaged var pagePHBManaged: Int32
    @NSManaged var levelManaged: Int32
    @NSManaged var hasDC: Bool
    @NSManaged var hasAttack: Bool
    @NSManaged var castAtHigherLevel: Bool
}
