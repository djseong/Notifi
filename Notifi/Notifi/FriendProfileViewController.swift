//
//  FriendProfileViewController.swift
//  
//
//  Created by Sam on 7/20/16.
//
//

import UIKit
import MessageUI

class FriendProfileViewController: UIViewController, MFMessageComposeViewControllerDelegate  {
    
    
    var tempName : String?
    var tempPhone : String?
    var tempEmergency : String?
    var tempAddress1: String?
    var tempAddress2: String?
    var tempImageString : String?
    var state : State?
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var emergencyPhoneLabel: UILabel!
    
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var address1: UILabel!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // make the address label wrap to more lines if needed
        self.address1.lineBreakMode = .ByWordWrapping
        self.address1.numberOfLines = 0
        
        self.nameLabel.text = tempName
        self.phoneLabel.text = tempPhone
        self.emergencyPhoneLabel.text = tempEmergency
        self.address1.text = tempAddress1

        
        
        
        self.profileImageView.frame.size.width = 150
        
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
        
        profileImageView.layer.borderWidth = 2.0
        
        if state == .Help {
            profileImageView.layer.borderColor = UIColor.redColor().CGColor
        }
        else if state == .Attention {
            profileImageView.layer.borderColor = UIColor.yellowColor().CGColor
        }
        else {
            profileImageView.layer.borderColor = UIColor.greenColor().CGColor
        }
        
        let url = tempImageString
        let picurl = NSURL(string: url!)
        profileImageView.load(picurl!)
        
        
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    @IBAction func textButtonPressed(sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [tempPhone!]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }

        
        
    }
    
    
    
    @IBAction func callButtonPressed(sender: UIButton) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(tempPhone!)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
        
    }
    
    
 
    
    
    
    @IBAction func eTextButtonPressed(sender: UIButton) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [tempEmergency!]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    
    
    
    @IBAction func eCallButtonPressed(sender: UIButton) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(tempEmergency)!)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
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
