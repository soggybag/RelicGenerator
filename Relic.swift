//
//  Relic.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/27/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import CoreData


class Relic: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    
    var cost: Int {
        get { return Int(costManaged) }
        set { costManaged = Int32(newValue) }
    }
    
    var casterLevel: Int {
        get { return Int(casterLevelManaged) }
        set { casterLevelManaged = Int32(newValue) }
    }
    
    var casterBonus: Int {
        get { return Int(casterBonusManaged) }
        set { casterBonusManaged = Int32(newValue) }
    }
    
    var spellDC: Int {
        get {
            return casterBonus + 8
        }
    }
}
