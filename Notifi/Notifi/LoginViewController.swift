//
//  LoginViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit

import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet var loginView: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        navigationItem.title = "Login"
    }
    
    override func viewDidAppear(animated: Bool) {

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
            if result.grantedPermissions.contains("email")
            {
                let defaults = NSUserDefaults.standardUserDefaults()
                // Do work
                //firebase connection
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                    // ...
                    print("firebase returned")
                    print(user)
                    if (error != nil) {
                        //
                        print("firebase login error: \(error)")
                        
                        
                    }   else    {
                        
                        //log in to app - set user defaults
                        defaults.setObject(SignifyUserController.sharedInstance.getLoginDetails(), forKey: "currentuseremail")
                        defaults.synchronize()
                        
                        let friendtablecontoller = FriendTableViewController(nibName: "FriendTableViewController", bundle: nil)
                        self.navigationController?.pushViewController(friendtablecontoller, animated: true) 
                    }
                    
                }
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }

   /* func returnUserData()
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
*/
}
