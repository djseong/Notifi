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
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true

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
        loginButton.enabled = true
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
        
        activityIndicator.startAnimating()
        activityIndicator.hidden = false
        loginButton.enabled = false
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self) { (result, error) in
            if error != nil {
                print("facebook login error")
            }
            else if result.isCancelled {
               
            }
            else {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                
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
                    else {
                        //log in to app - set user defaults

                        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, first_name, picture.type(large)"])


                        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                            if error == nil {
                                let url = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url")
                                if url != nil {
                                let picurl = NSURL(string: url! as! String)
                                let welcomepageviewcontroller = WelcomePageViewController(nibName: "WelcomePageViewController", bundle: nil)
                                let vc = welcomepageviewcontroller.viewcontrollers[0] as! FirstPageController
                                vc.tempimage.load(picurl!, placeholder: UIImage(), completionHandler: { (url, image, error, cache) in
                                    if error == nil {
                                        print ("inside closure")
                                        if let firstname = result.valueForKey("first_name") as? String {
                                            vc.templabel = "Welcome " + firstname + "!"
                                            var lastName:String
                                            if result.valueForKey("last_name") != nil{
                                                lastName = result.valueForKey("last_name") as! String
                                            }else{
                                                lastName = "Unknown"
                                            }
                                            let fbId = result.valueForKey("id") as! String
                                            SignifyUserController.sharedInstance.currentUser = SignifyUser(lastName: lastName, firstName: firstname, imageString: String(url), fbId: result.valueForKey("id") as! String)
                                            // user persistence
                                            defaults.setObject(fbId, forKey: "currentuserfbId")
                                            defaults.setObject(firstname, forKey: "currentuserfirstname")
                                            defaults.setObject(String(url), forKey: "currentuserpicture")
                                            defaults.synchronize()
                                            
                                            // register on server
                                            WebDatabase.sharedInstance.resgisterUser(fbId, firstName: firstname, lastName:  lastName, profileImage: String(url))
                                        }
                                        self.navigationController?.pushViewController(welcomepageviewcontroller, animated: true)
                                    }
                                    else {
                                        print(error)
                                    }
                                })
                                
                                    self.activityIndicator.stopAnimating()
                                    self.activityIndicator.hidden = true//let data = NSData(contentsOfURL: picurl!)
                                    //self.profileImage.load(picurl!) //= UIImage(data: data!)
                                }
                                
                            }
                        })

                    }
                    
                
            }
        }
        }
//        let loginviewcontroller = LoginViewController(nibName: "LoginViewController", bundle: nil)
//        self.navigationController?.pushViewController(loginviewcontroller, animated: true)
    }

}
