//
//  ScrollViewController.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 1/2/16.
//  Copyright © 2016 mitchell hudson. All rights reserved.
//




// TODO: Display the current scroll
// TODO: Format text display of scroll
// TODO: Email Scrolls
// TODO: Message Scroll



import UIKit
import MessageUI


class ScrollViewController: UIViewController, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    
    var scroll: ScrollObject?
    
    
    // ------------------------------------------------------------------------
    
    // MARK: IBOutlets
    
    @IBOutlet weak var textView: UITextView!
    
    
    
    // ------------------------------------------------------------------------
    
    // MARK: IBActions
    
    @IBAction func randomScrollButtonTapped(sender: UIButton) {
        getRandomScroll()
        displayScroll()
    }
    
    // Send Scroll Bar Button
    @IBAction func sendScrollButtonTapped(sender: UIBarButtonItem) {
        openSendRelicActionSheet()
    }
    
    
    @IBAction func infoBarButtonTapped(sender: UIBarButtonItem) {
        let infoAlert = UIAlertController(title: "Relic Generator", message: infoStr, preferredStyle: .ActionSheet)
        let close = UIAlertAction(title: "Close", style: .Default, handler: nil)
        let sly = UIAlertAction(title: "Visit Slyflourish", style: .Default) { (action:UIAlertAction) -> Void in
            //
        }
        
        infoAlert.addAction(close)
        infoAlert.addAction(sly)
        
        presentViewController(infoAlert, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    // ----------------------------------------------------
    
    // MARK: Display Email and Message actionsheet
    
    func openSendRelicActionSheet() {
        let alert = UIAlertController(title: "Send Scroll", message: nil, preferredStyle: .ActionSheet)
        
        let message = UIAlertAction(title: "Text Message", style: .Default) { (action: UIAlertAction) -> Void in
            self.messageScroll()
        }
        
        let email = UIAlertAction(title: "Email", style: .Default) { (action: UIAlertAction) -> Void in
            self.emailScroll()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        if MFMessageComposeViewController.canSendText() {
            alert.addAction(message)
        }
        
        if MFMailComposeViewController.canSendMail() {
            alert.addAction(email)
        }
        
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func messageScroll() {
        let messageVC = MFMessageComposeViewController()
        // *** Scroll text for message
        messageVC.body = scroll?.getFullDescriptionForDisplay()
        messageVC.recipients = []
        messageVC.messageComposeDelegate = self
        
        presentViewController(messageVC, animated: true, completion: nil)
    }
    
    func emailScroll() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([])
        mailVC.setSubject("Relic")
        // *** Scroll text for email
        mailVC.setMessageBody((scroll?.getFullDescriptionForDisplay())!, isHTML: true)
        
        presentViewController(mailVC, animated: true, completion: nil)
    }

    // ---------------------------------------------------------------------------------------------
    // MARK: Email Delegate Methods
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Message Delegate Methods
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch result.rawValue {
        case MessageComposeResultCancelled.rawValue :
            print("message canceled")
            
        case MessageComposeResultFailed.rawValue :
            print("message failed")
            
        case MessageComposeResultSent.rawValue :
            print("message sent")
            
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // ------------------------------------------------------------------------
    
    // MARK: Utility Functions
    
    
    func formatSpell(scrollSpell: ScrollSpell) -> String {
        var str = ""
        let spell = scrollSpell.spellEffect!
        
        str += spell.name!
        if spell.hasDC || spell.hasAttack || spell.castAtHigherLevel {
            str += " Cast at level \(spell.level);"
        }
        
        if spell.castAtHigherLevel {
            str += " caster level \(scrollSpell.casterLevel); "
        }
        
        if spell.hasDC {
            str += " Save DC \(scrollSpell.spellDC); "
        }
        
        if spell.hasAttack {
            str += " spell attack \(scrollSpell.casterBonus) "
        }
        
        str += ". PHB pg \(spell.pagePHB); "
        str += " cost: \(scrollSpell.cost)."
        
        return str
    }
    
    
    func displayScroll() {
        textView.text = scroll?.getFullDescriptionForDisplay()
    }
    
    
    func getRandomScroll() {
        scroll = ScrollManager.sharedInstance.getARandomScroll()
    }
    
    
    
    // ------------------------------------------------------------------------
    
    // MARK: View Life Cycle
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // If the current scroll is nil get a random scroll
        if scroll == nil {
            getRandomScroll()
        }
        displayScroll()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
