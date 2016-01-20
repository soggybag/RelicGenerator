//
//  ScrollObject.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 1/17/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import Foundation
import UIKit

struct ScrollObject {
    let scroll: Scroll!
    let spells: [ScrollSpell]!
    
    
    // TODO: Sort by level
    func getSpellLevels() -> String {
        var str = ""
        for spell in spells {
            str += "\(spell.spellEffect!.level),"
        }
        return str
    }
    
    
    
    func getDescriptionForSpell(scrollSpell: ScrollSpell) -> String {
        var str = ""
        str += "\(scrollSpell.spellEffect!.name!) level:\(scrollSpell.spellEffect!.level)\n"
        
        return str 
    }
    
    
    
    // ----------------------------------------------------------
    // MARK: Get scroll description for Table view cells
    
    func getDescriptionForTableCell() -> String {
        var str = "Scroll number of spells \(spells.count)"
        for spell in spells {
            str += " Levels: \(getSpellLevels())"
            str += " \(spell.spellEffect!.name!)"
        }
        return str
    }

    
    // MARK: Get scroll description for text display
    
    func getFullDescriptionForDisplay() -> String {
        var str = ""
        str += "Number of Spells: \(spells.count)"
        str += "Levels: \(getSpellLevels())\n"
        for scrollSpell in spells {
            str += getDescriptionForSpell(scrollSpell)
        }
        return str
    }
    // ---------------------------------------------------------
    
    
    init(scroll: Scroll, spells: [ScrollSpell]) {
        self.scroll = scroll
        self.spells = spells
    }
}
