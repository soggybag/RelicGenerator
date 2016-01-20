//
//  RelicManager.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/25/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import GameplayKit

class RelicManager {
    
    static let sharedInstance = RelicManager()
    
    let context: NSManagedObjectContext!
    var selectedRelic: Relic?
    var relics = [Relic]()
    var count: Int {
        get {
            return relics.count
        }
    }
    
    // Select Relic at index
    func selectRelicAtIndex(index: Int) {
        selectedRelic = relicAtIndex(index)
    }
    
    // Clear the selected relic
    func clearSelectedRelic() {
        selectedRelic = nil
    }
    
    
    // Get a random relic
    func randomRelic() -> Relic {
        let n = GKRandomSource.sharedRandom().nextIntWithUpperBound(count)
        return relicAtIndex(n)
    }
    
    // Get a relic by it's index
    func relicAtIndex(index: Int) -> Relic {
        return relics[index]
    }
    
    
    func randomRange(range: Int) -> Int {
        return GKRandomSource.sharedRandom().nextIntWithUpperBound(range)
    }
    
    func getRandomSpellLevelWeightedForRoll(roll: Int) -> Int {
        if roll < 10 {
            return 0
        } else if roll < 25 {
            return 1
        } else if roll < 40 {
            return 2
        } else if roll < 55 {
            return 3
        } else if roll < 70 {
            return 4
        } else if roll < 85 {
            return 5
        } else if roll < 90 {
            return 6
        } else if roll < 95 {
            return 7
        } else if roll < 98 {
            return 8
        } else {
            return 9
        }
    }
    
    func getCasterLevel(spellLevel: Int) -> Int {
        let n = randomRange(100)
        let l = (getRandomSpellLevelWeightedForRoll(n) * 2) + (n % 2)
        if l <= spellLevel * 2 {
            return spellLevel * 2
        }
        return l
    }
    
    
    
    
    // Add a new Relic
    func addNewRelic() {
        let newRelic = NSEntityDescription.insertNewObjectForEntityForName("Relic", inManagedObjectContext: context) as! Relic
        let spell = SpellManager.sharedInstance.getRandomSpellWeightedForLevel()
        
        newRelic.objectDescription = ObjectGenerator.getDescription()
        newRelic.spellEffect = spell
        newRelic.cost = SpellManager.sharedInstance.getCostForSpellLevel(spell.level)
        newRelic.casterLevel = getCasterLevel(spell.level)
        newRelic.casterBonus = randomRange(Int(newRelic.casterLevel))
        
        saveContext()
        
        relics.insert(newRelic, atIndex: 0)
    }
    
    
    // Remove a relic at index
    func removeRelicAtIndex(index: Int) {
        context.deleteObject(relicAtIndex(index))
        saveContext()
        relics.removeAtIndex(index)
    }
    
    
    // Save Core data
    func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Error saving Relic:\(error), \(error.userInfo)")
        }
    }
    
    // Load Relics from Core Data
    func loadRelics() {
        let fetchRequest = NSFetchRequest(entityName: "Relic")
        do {
            let results = try context.executeFetchRequest(fetchRequest)
            relics = (results as! [Relic]).reverse()
        } catch let error as NSError {
            print("Error fetching Relics:\(error), \(error.userInfo)")
        }
    }
    
    // Generate a list 100 starting relics
    func generateStartingRelics() {
        for _ in 1...100 {
            addNewRelic()
        }
    }
    
    // MARK: Init
    private init() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        loadRelics()
        
        // Check for initial load
        if relics.count == 0 {
            // Add 100 new relics
            generateStartingRelics()
        }
    }
}