//
//  ListScrollsViewController.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 1/17/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//

import UIKit

class ListScrollsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    
    
    
    
    
    
    
    
    // MARK: TableView DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ScrollManager.sharedInstance.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        let scrollObject = ScrollManager.sharedInstance.scrollAtIndex(indexPath.row)
        let scrollObjectTableCellDescription = scrollObject.getDescriptionForTableCell()
        cell?.textLabel?.text = "\(scrollObjectTableCellDescription)"
        
        return cell!
    }
    
    
    
    
    // MAR: TableView Delegate methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ScrollManager.sharedInstance.scrollAtIndex(indexPath.row)
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("List scrolls loaded")
        print("Scroll Count:\(ScrollManager.sharedInstance.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
