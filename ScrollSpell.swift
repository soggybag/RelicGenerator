//
//  ScrollSpell.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 1/16/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation
import CoreData


class ScrollSpell: NSManagedObject {

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
