//
//  OnboardingViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class OnboardingViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    //@IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set colors
        self.titleLabel.textColor = UIColor.whiteColor()
        
        // Button segues
       // registerButton.addTarget(self, action: #selector(registerView), forControlEvents: .TouchUpInside)
        loginButton.addTarget(self, action: #selector(loginView), forControlEvents: .TouchUpInside)
        
        // navigation controller
        navigationController?.navigationBar.barStyle = UIBarStyle.Black

        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addGradient(from: .notifiTeal(), to: .notifiDarkTeal())
    }
    
    func registerView() {
        let registerviewcontroller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(registerviewcontroller, animated: true)
    }
    
    func loginView() {
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"]) { (result, error) in
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
                        
                   //     let welcomeviewcontroller = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
             //           self.navigationController?.pushViewController(welcomeviewcontroller, animated: true)
                    }
                    
                }
            }
        }
//        let loginviewcontroller = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        self.navigationController?.pushViewController(loginviewcontroller, animated: true)
    }

}
