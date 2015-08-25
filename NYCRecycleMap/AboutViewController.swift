//
//  AboutViewController.swift
//  NYCRecycleMap
//
//  Created by Ely on 8/25/15.
//  Copyright (c) 2015 Erg Process Energy, LLC. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "About"
        
        // Email Button
        var rightEmailBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: "sendEmail:")
        
        // Display buttons
        self.navigationItem.setRightBarButtonItems([rightEmailBarButtonItem], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Send email
    
    var mailComposer:MFMailComposeViewController?
    
    @IBAction func sendEmail(sender: UIButton) {
        
        if MFMailComposeViewController.canSendMail() {
            // Configure the email
            self.mailComposer = MFMailComposeViewController()
            self.mailComposer?.navigationBar.tintColor = UIColor.whiteColor()
            
            // Set delegate method so user will return to previous view after sending email
            self.mailComposer?.mailComposeDelegate = self
            
            // Confifure email properties
            self.mailComposer?.setToRecipients(["contact@ergprocess.com"])
            self.mailComposer?.setSubject("NYC Recycle Map Inquiry")
            
            // Pop up the email
            self.presentViewController(self.mailComposer!, animated: true, completion: nil)
            
        } else {
            //Alert user that they cannot send an email
            NSLog("Device not configured for email")
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        
        // Evaluate whether message was sent, saved, or failed
        
        switch(result.value) {
        case MFMailComposeResultSent.value:
            // TO DO Alert user that mail was sent
            NSLog("Mail was sent")
        case MFMailComposeResultCancelled.value:
            NSLog("Message cancelled")
        case MFMailComposeResultSaved.value:
            NSLog("Message saved")
        case MFMailComposeResultFailed.value:
            NSLog("Message failed")
        default:
            NSLog("default happened")
        }
        
        // Dismiss the mail view
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
