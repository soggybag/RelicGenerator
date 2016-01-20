//
//  SpellManager.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/24/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import GameplayKit

class SpellManager {
    // Singleton
    static let sharedInstance = SpellManager()
    
    let context: NSManagedObjectContext!
    var spells = [Spell]()
    var spellListByLevel = [[Spell]]()
    
    
    func randomRange(range: Int) -> Int {
        let n = GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
        return n
    }
    
    
    // Get a Random spell of any level
    func getRandomSpell() -> Spell {
        return getRandomSpellFromList(spells)
    }
    
    // Get random spell from list
    func getRandomSpellFromList(list: [Spell]) -> Spell {
        return list[randomRange(list.count)]
    }
    
    // Get a random spell of Level
    func getRandomSpellOfLevel(level: Int) -> Spell {
        return self.getRandomSpellFromList(self.spellListByLevel[level])
    }
    
    // Random Spell weighted for level
    
    func getRandomSpellWeightedForLevel() -> Spell {
        let n = self.randomRange(100)
        var level = 0
        if n < 10 {
            level = 0
        } else if n < 25 {
            level = 1
        } else if n < 40 {
            level = 2
        } else if n < 55 {
            level = 3
        } else if n < 70 {
            level = 4
        } else if n < 85 {
            level = 5
        } else if n < 90 {
            level = 6
        } else if n < 95 {
            level = 7
        } else if n < 98 {
            level = 8
        } else {
            level = 9
        }
        
        return self.getRandomSpellOfLevel(level)
    }
    
    
    
    // MARK: Cost
    
    func getCostForSpellLevel(level: Int) -> Int {
        switch level {
        case 0 :
            return 100
            
        case 1..<5 :
            return level * 100
            
        case 5..<11 :
            return 2500 * level / 10
            
        default :
            return 25000 * level / 16
        }
    }



    
    
    func getSpells(spellList: NSArray) {
        
        for spell in spellList {
            let newSpell = NSEntityDescription.insertNewObjectForEntityForName("Spell", inManagedObjectContext: context) as! Spell
            newSpell.name = spell["name"] as? String
            newSpell.level = Int((spell["level"] as! String))!
            newSpell.castAtHigherLevel = Int((spell["castAtHigherLevel"] as! String))!.toBool()!
            newSpell.hasDC = Int((spell["hasDC"] as! String))!.toBool()!
            newSpell.hasAttack = Int((spell["hasAttack"] as! String))!.toBool()!
            newSpell.pagePHB = Int((spell["pagePHB"] as! String))!
            
            spells.append(newSpell)
            
            saveContext()
        }
    }
    
    // Organize spells into arrays by level
    func organizeSpellsByLevel() {
        // Find highest level spell
        var maxLevel = 0
        for spell in self.spells {
            if maxLevel < Int(spell.level) {
                maxLevel = Int(spell.level)
            }
        }
        
        spells.sortInPlace {$0.level < $1.level}
        
        for spell in spells {
            if spellListByLevel[safe: Int(spell.level)] != nil {
                spellListByLevel[Int(spell.level)].append(spell)
            } else {
                spellListByLevel.append([spell])
            }
        }
        
    }
    
    
    
    func loadDataFromPlist(plist: String) -> NSArray? {
        if let path = NSBundle.mainBundle().pathForResource(plist, ofType: "plist") {
            return NSArray(contentsOfFile: path)
        }
        return nil
    }
    
    
    func loadSpells() {
        let fetchRequest = NSFetchRequest(entityName: "Spell")
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            spells = results as! [Spell]
        } catch let error as NSError {
            print("Could not fetch Spells:\(error), \(error.userInfo)")
        }
    }
    
    func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Error saving context:\(error), \(error.userInfo)")
        }
    }
    
    private init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        loadSpells()
        print("Load Spells")
        
        if spells.count == 0 {
            print("No Spells")
            if let spellList = self.loadDataFromPlist("spells") {
                // print("Load Spells from plist")
                getSpells(spellList)
                // print("Get Spells")
            }
        }
        
        organizeSpellsByLevel()
        // print("Organize Spells")
        // print(spellListByLevel.count)
    }
}
