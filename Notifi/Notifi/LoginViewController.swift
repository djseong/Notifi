//
//  LoginViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var loginView: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        navigationItem.title = "Login"
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            let friendtablecontoller = FriendTableViewController(nibName: "FriendTableViewController", bundle: nil)
            self.navigationController?.pushViewController(friendtablecontoller, animated: true)
            // User is already logged in, do work such as go to next view controller.
            // Get List Of Friends
           /* let friendRequest = FBSDKGraphRequest(graphPath: "me/invitable_friends", parameters: ["fields" : "id, name, picture", "after" : "QVZAtaWpPMlg3M2FHYTNEQmwwcVl6eUp5XzRNYXlGaUJZAR01KZAnBpREpHV0FJM2tTUjVYWHg0cWE2WnFYUGZA4YVYtYVU1bHJoN2RISDZAkU2REZAEY3dENzcU9FLVFVaF94eGZAKY1J4TVMxc3YwZA3cZD"], HTTPMethod: "GET")
            friendRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                print(result)

            })*/
        }
        else
        {
            
        }
    }
    
    // Facebook Delegate Methods
    
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
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            returnUserData()
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }

}
