//
//  ListRelicsViewController.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/25/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//


// TODO: Add Spell level to description in cells
// TODO: Set row height
// TODO: Set correct color for new rows, and when rows are deleted
// TODO: Add sort for Cost or Name with Segmented control


import UIKit

class ListRelicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Some constants 
    let evenColor = UIColor(white: 0.92, alpha: 1.0)
    let oddColor = UIColor(white: 0.97, alpha: 1.0)
    
    var selectedRelic: Relic?
    
    
    // ----------------------------------------------------------------------------------------------
    // MARK: IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // ----------------------------------------------------------------------------------------------
    // MARK: IBActions
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        addNewrelic()
    }
    
    
    // ----------------------------------------------------------------------------------------------
    // MARK: Helper Methods
    
    func addNewrelic() {
        RelicManager.sharedInstance.addNewRelic()
        // TODO: Animate new row
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
        tableView.reloadData()
        setTitleWithCount()
    }
    
    func setTitleWithCount() {
        navigationItem.title = "\(RelicManager.sharedInstance.count) Relics"
    }
    
    
    // ----------------------------------------------------------------------------------------------
    // MARK: TableView Datasource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RelicManager.sharedInstance.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        let relic = RelicManager.sharedInstance.relicAtIndex(indexPath.row)
        let spellName = relic.spellEffect?.name!
        let objectDescription = relic.objectDescription!
        let cost = relic.cost
        cell.textLabel?.text = "\(objectDescription) (\(cost) gp)"
        cell.detailTextLabel?.text = spellName
        
        // Cell Color
        if indexPath.row % 1 == 0 {
            cell.backgroundColor = evenColor
        } else {
            cell.backgroundColor = oddColor
        }
        
        // Cell Image
        cell.imageView?.image = RelicIconManager.sharedInstance.iconImageAtIndex(indexPath.row % RelicIconManager.sharedInstance.count)
        
        return cell
    }
    
    
    // ----------------------------------------------------------------------------------------------
    // MARK: TableView Delegate methods
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            RelicManager.sharedInstance.removeRelicAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
            setTitleWithCount()
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        RelicManager.sharedInstance.selectRelicAtIndex(indexPath.row)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    // ----------------------------------------------------------------------------------------------
    // MARK: View LifeCycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedRelic = nil
        setTitleWithCount()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // ---------------------------------------------------------------------------------------------
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}
