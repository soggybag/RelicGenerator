//
//  ViewController.swift
//  RelicGenerator
//
//  Created by mitchell hudson on 12/18/15.
//  Copyright © 2015 mitchell hudson. All rights reserved.
//


import UIKit
import MessageUI

let infoStr = "Relic generator generates random single use magic items for D&D5e. Built by Mitchell Hudson from original online editor by Slyflurish."

class ViewController: UIViewController,
UITextViewDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    // Store the selected and displayed relic
    var relic: Relic?
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: IBOutlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var randomRelicButton: UIButton!
    @IBOutlet weak var sendBarButton: UIBarButtonItem!
    @IBOutlet weak var listBarButton: UIBarButtonItem!
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: IBActions
    
    @IBAction func randomRelicButtonTapped(sender: UIButton) {
        RelicManager.sharedInstance.clearSelectedRelic()
        relic = RelicManager.sharedInstance.randomRelic()
        displayRelic()
    }
    
    
    @IBAction func sendRelicButtonTapped(sender: UIBarButtonItem) {
        openSendRelicActionSheet()
    }
    
    @IBAction func gotoListView(sender: UIBarButtonItem) {
        performSegueWithIdentifier("ToListViewSegue", sender: self)
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
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Display Alert for email and text messages
    
    func openSendRelicActionSheet() {
        let alert = UIAlertController(title: "Send Relic", message: nil, preferredStyle: .ActionSheet)
        
        let message = UIAlertAction(title: "Text Message", style: .Default) { (action: UIAlertAction) -> Void in
            self.messageRelic()
        }
        
        let email = UIAlertAction(title: "Email", style: .Default) { (action: UIAlertAction) -> Void in
            self.emailRelic()
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
    
    
    func messageRelic() {
        let messageVC = MFMessageComposeViewController()
        messageVC.body = formatRelicString()
        messageVC.recipients = []
        messageVC.messageComposeDelegate = self
        
        presentViewController(messageVC, animated: true, completion: nil)
    }
    
    func emailRelic() {
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients([])
        mailVC.setSubject("Relic")
        mailVC.setMessageBody(formatRelicStringAsHTML(), isHTML: true)
        
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
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Format text for display
    
    func formatRelicString() -> String {
        var str = ""
        
        if let relic = relic {
            if let objectDescription = relic.objectDescription {
                str += objectDescription
            }
            
            if let spell = relic.spellEffect {
                if let name = spell.name {
                    str += ". Casts \(name)\n"
                }
                if spell.hasDC || spell.hasAttack || spell.castAtHigherLevel {
                    str += "Cast at level \(spell.level); "
                }
                if spell.castAtHigherLevel {
                    str += ", caster level \(relic.casterLevel); "
                }
                if spell.hasDC {
                    str += ". Save DC \(relic.spellDC); "
                }
                if spell.hasAttack {
                    str += "spell attack \(relic.casterBonus); "
                }
                
                str += "PHB pg \(spell.pagePHB); "
                str += "Cost: \(relic.cost) gp"
            }
        }
        
        return str
    }
    
    func formatRelicStringAsHTML() -> String {
        var str = "<style type='text/css'>h1 {margin-bottom: 0; font-size:24pt}</style>"
        
        if let relic = relic {
            if let objectDescription = relic.objectDescription {
                str += "<h1>\(objectDescription).</h1><br>"
            }
            
            if let spell = relic.spellEffect {
                if let name = spell.name {
                    str += "Casts <strong>\(name)</strong><br>"
                }
                if spell.hasDC || spell.hasAttack || spell.castAtHigherLevel {
                    str += "Cast at level \(spell.level); "
                }
                if spell.castAtHigherLevel {
                    str += ", caster level \(relic.casterLevel); "
                }
                if spell.hasDC {
                    str += " save DC \(relic.spellDC); "
                }
                if spell.hasAttack {
                    str += "spell attack \(relic.casterBonus); "
                }
                
                str += "PHB pg \(spell.pagePHB); "
                str += "Cost: \(relic.cost) gp"
            }
        }
        
        return str
    }
    
    
    
    
    // ---------------------------------------------------------------------------------------------
    // Dipslay relic in text view
    
    func displayRelic() {
        // textView.text = formatRelicString()
        textView.attributedText = stringToAttributedString(formatRelicStringAsHTML())
    }
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: - String to Attributed String
    // Helper method for formatting text as attributed text
    func stringToAttributedString(str: String) -> NSAttributedString {
        var html = str
        while let range = html.rangeOfString("\n") {
            html.replaceRange(range, with: "</br>")
        }
        
        html = "<span style='font-family: Helvetica; font-size:14pt; line-height:18pt'>"+html+"</span>"
        let data = html.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)
        let attrStr = try! NSAttributedString(data: data!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        return attrStr
    }
    
    
    
    // ---------------------------------------------------------------------------------------------
    // Key board set up
    
    func addDoneButtonToKeyBoard() {
        let doneToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolBar.barStyle = .BlackTranslucent
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: "doneButtonAction:")
        let items = [flexSpace, doneButton]
        
        doneToolBar.items = items
        doneToolBar.sizeToFit()
        self.textView.inputAccessoryView = doneToolBar
    }
    
    func doneButtonAction(sender: AnyObject) {
        // print("Done button Tapped")
        self.view.endEditing(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.view.endEditing(true)
    }
    
    
    
    // ---------------------------------------------------------------------------------------------
    // MARK: View Lifecycle
    
    // Fetch a relic to display
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // If a relic was selected from the list show it, otherwise choose one at random
        if let selectedRelic = RelicManager.sharedInstance.selectedRelic {
            relic = selectedRelic
        } else {
            relic = RelicManager.sharedInstance.randomRelic()
        }
        // Display the relic
        displayRelic()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Add Done Button to keyboard
        addDoneButtonToKeyBoard()
        
        // Make some special image buttons for the navigation bar
        // let buttonImage = RelicStyleKit.imageOfCanvas1(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        let buttonImage = RelicStyleKit.imageOfCanvas1(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        randomRelicButton.tintColor = UIColor.whiteColor()
        randomRelicButton.setImage(buttonImage, forState: .Normal)
        randomRelicButton.setTitle(" \(randomRelicButton.titleForState(.Normal)!)", forState: .Normal)
        
        
        // Make left bar button from stylekit
        let barButtonSize = 30
        let img = RelicStyleKit.imageOfCanvas52(frame: CGRect(x: 0, y: 0, width: barButtonSize, height: barButtonSize))
        let barButton = UIBarButtonItem(image: img, style: .Plain, target:self, action: "sendRelicButtonTapped:")
        
        let info = RelicStyleKit.imageOfCanvas38(frame: CGRect(x: 0, y: 0, width: barButtonSize, height: barButtonSize))
        let infoBarButton = UIBarButtonItem(image: info, style: .Plain, target: self, action: "infoBarButtonTapped:")
        navigationItem.setLeftBarButtonItems([barButton, infoBarButton], animated: true)
        
        // Make the right bar button from style kit
        let dna = RelicStyleKit.imageOfCanvas36(frame: CGRect(x: 0, y: 0, width: barButtonSize * 14 / 22, height: barButtonSize))
        let rightBarButton = UIBarButtonItem(image: dna, style: .Plain, target: self, action: "gotoListView:")
        
        navigationItem.setRightBarButtonItems([rightBarButton], animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

