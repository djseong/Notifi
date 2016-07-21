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
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self) { (result, error) in
            if error != nil {
                print("facebook login error")
            }
            else if result.isCancelled {
               
            }
            else {
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
                        
                        
                    }
                    else if result.isCancelled {
                        print("facebook login cancelled")
                    }
                    else    {
                        
                        //log in to app - set user defaults
                        defaults.setObject(SignifyUserController.sharedInstance.getLoginDetails(), forKey: "currentuseremail")
                        SignifyUserController.sharedInstance.currentUser.emailAddress = "515948294@qq.com"
                        defaults.synchronize()
                        let application = AppDelegate()
                       self.navigationController?.pushViewController(application.initTabBarController(), animated: true)

                        
                   //     let welcomeviewcontroller = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
             //           self.navigationController?.pushViewController(welcomeviewcontroller, animated: true)

                        let welcomepageviewcontroller = WelcomePageViewController(nibName: "WelcomePageViewController", bundle: nil)
                        self.navigationController?.pushViewController(welcomepageviewcontroller, animated: true)

                    }
                    
                }
            }
        }
        }
//        let loginviewcontroller = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        self.navigationController?.pushViewController(loginviewcontroller, animated: true)
    }

}
