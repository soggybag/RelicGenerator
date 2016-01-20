//
//  ScrollSpell+CoreDataProperties.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 1/16/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ScrollSpell {

    @NSManaged var casterBonusManaged: Int32
    @NSManaged var casterLevelManaged: Int32
    @NSManaged var costManaged: Int32
    @NSManaged var spellEffect: Spell?
    @NSManaged var scroll: NSManagedObject?

}
