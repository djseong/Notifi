//
//  RegisterViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import SwiftyJSON

class RegisterViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var fbRegisterButton: FBSDKLoginButton!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cellNumberField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fbRegisterButton.readPermissions = ["public_profile", "email", "user_friends"]
        fbRegisterButton.delegate = self
        
        //Navigation bar 
        navigationItem.title = "Create Account"
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        let titletext = NSAttributedString(string: "Register with Facebook")
        fbRegisterButton.setAttributedTitle(titletext, forState: .Normal)
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        profileImage.round()

    }

    @IBAction func registerButtonPressed(sender: NextButton) {
        for subview in self.view.subviews {
            if let textfield = subview as? UITextField {
                if textfield.text == "" {
                    let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: UIAlertControllerStyle.Alert)
                    let alertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: nil)
                    alert.addAction(alertAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    // Facebook Delegate methods
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, last_name, email, picture.type(large)"])
            graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                self.firstNameField.text = result.valueForKey("first_name") as! String
                self.lastNameField.text = result.valueForKey("last_name") as! String
                self.emailField.text = result.valueForKey("email") as! String
                let titletext = NSAttributedString(string: "Successfully Registered")
                self.fbRegisterButton.setAttributedTitle(titletext, forState: .Normal)
                let url = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url")
                if url != nil {
                    let picurl = NSURL(string: url! as! String)
                    let data = NSData(contentsOfURL: picurl!)
                    self.profileImage.image = UIImage(data: data!)
                }
                
            })
            
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }


}
