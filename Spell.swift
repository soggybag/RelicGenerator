//
//  Spell.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/27/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import CoreData


class Spell: NSManagedObject {

    // Insert code here to add functionality to your managed object subclass
    
    var pagePHB: Int {
        get { return Int(pagePHBManaged) }
        set { pagePHBManaged = Int32(newValue) }
    }
    
    var level: Int {
        get { return Int(levelManaged) }
        set { levelManaged = Int32(newValue) }
    }
}
