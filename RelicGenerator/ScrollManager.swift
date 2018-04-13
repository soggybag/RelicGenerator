//
//  ScrollManager.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/30/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ScrollManager {
    static let sharedInstance = ScrollManager()
    
    var scrolls = [ScrollObject]()
    var selectedScroll: ScrollObject?
    
    let context: NSManagedObjectContext!
    
    var count: Int {
        get {
            return scrolls.count
        }
    }
    
    
    
    // -------------------------------------------
    // MARK:
    
    func selectScrollAtIndex(index: Int) {
      selectedScroll = scrollAtIndex(index: index)
    }
    
    
    
    // Get the scroll at index
    
    func scrollAtIndex(index: Int) -> ScrollObject {
        return scrolls[index]
    }
    
    func getARandomScroll() -> ScrollObject {
      return scrollAtIndex(index: Int.randomRange(range: count))
    }
    
    
    
    // *********
    // MARK: Scroll Spell
    
    // Generate a ScrollSpell - a spell including caster level bonues etc.
    func generateScrollSpell() -> ScrollSpell {
      let scrollSpell = NSEntityDescription.insertNewObject(forEntityName: "ScrollSpell", into: context) as! ScrollSpell
        let spell = SpellManager.sharedInstance.getRandomSpellWeightedForLevel()
        
        scrollSpell.spellEffect = spell
      scrollSpell.cost = SpellManager.sharedInstance.getCostForSpellLevel(level: spell.level)
      scrollSpell.casterLevel = RelicManager.sharedInstance.getCasterLevel(spellLevel: spell.level)
      scrollSpell.casterBonus = RelicManager.sharedInstance.randomRange(range: Int(scrollSpell.casterLevel))
        
        saveContext()
        
        return scrollSpell
    }
    
    // Generate a new scroll -
    func generateNewScroll(numberofSpells: Int) -> Scroll {
      let scroll = NSEntityDescription.insertNewObject(forEntityName: "Scroll", into: context) as! Scroll
        // print("*********** Adding spells to scroll")
        for _ in 1...numberofSpells {
            let scrollSpell = generateScrollSpell()
            // print(scrollSpell.spellEffect?.name)
            scrollSpell.scroll = scroll
        }
        
        saveContext()
        
        return scroll
    }
    
    func getScrolls() -> [Scroll] {
        var scrolls = [Scroll]()
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Scroll")
        do {
          let results = try context.fetch(request)
            scrolls = results as! [Scroll]
        } catch let error as NSError {
            print("Error fetching Scrolls \(error); \(error.userInfo)")
        }
        
        return scrolls
    }
    
    
    func getSpellsForScroll(scroll: Scroll) -> [ScrollSpell] {
        // print(">> getSpellsForScroll")
        var spells = [ScrollSpell]()
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ScrollSpell")
        request.predicate = NSPredicate(format: "scroll == %@", argumentArray: [scroll])
        
        do {
          let results = try context.fetch(request)
            spells = results as! [ScrollSpell]
        } catch let error as NSError {
            print("Error fetch Scroll Spells \(error); \(error.userInfo)")
        }
        
        return spells
    }
    // *********
    
    
    
    // Save Core data
    func saveContext() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Error saving Relic:\(error), \(error.userInfo)")
        }
    }
    
    
    // Make a scroll Object for each scroll in array
    func makeScrollObjects(scrolls: [Scroll]) {
        for scroll in scrolls {
          self.scrolls.append(ScrollObject(scroll: scroll, spells: getSpellsForScroll(scroll: scroll)))
        }
    }
    
    
    
    func loadScrolls() {
      let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Scroll")
        do {
          let results = try context.fetch(request)
          makeScrollObjects(scrolls: results as! [Scroll])
        } catch let error as NSError {
            print("Load Scrolls Error: \(error); \(error.userInfo)")
        }
    }
    
    
    func generateDefaultScrolls() {
        // Run this function once if there are no scrolls
        for _ in 1...100 {
          let numberOfSpells = Int.randomRange(range: 6) + 1
          generateNewScroll(numberofSpells: numberOfSpells)
        }
        // Since we just generated the default scrolls load them up
        loadScrolls()
    }
    
    
    
    
    init() {
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.managedObjectContext
        
        // Load Scrolls from core data
        loadScrolls()
        // Check that there are scrolls, if not add 100
        if scrolls.count == 0 {
            generateDefaultScrolls()
        }
    }
    
}
