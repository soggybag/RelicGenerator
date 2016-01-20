//
//  Relic+CoreDataProperties.swift
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

extension Relic {

    @NSManaged var name: String?
    @NSManaged var objectDescription: String?
    @NSManaged var costManaged: Int32
    @NSManaged var casterLevelManaged: Int32
    @NSManaged var casterBonusManaged: Int32
    @NSManaged var spellEffect: Spell?

}
