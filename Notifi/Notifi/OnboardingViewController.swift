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
                                            defaults.setObject(false, forKey: "UseMyLocation")
                                            defaults.synchronize()
                                            
                                            // register/login on server
                                            let apiService = APIService()
                                            let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/access/login"),method:"POST",parameters:["facebook_id": fbId, "password": fbId])
                                            apiService.executeRequest(request, requestCompletionFunction: {respondCode, json in
                                                if respondCode/100 == 2 {
                                                    print("log in successfully")
                                        APIServiceController.sharedInstance.updateProfile(["profile_pic":String(url),"first_name":firstname])
                                            
                                            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                            APIServiceController.sharedInstance.updateDeviceToken(appDelegate.device_token)
                                                APIServiceController.sharedInstance.populateFriendList()
                                                    if json["phone_num"].stringValue != ""{
                                                        SignifyUserController.sharedInstance.currentUser.cellPhone = json["phone_num"].stringValue
                                                        defaults.setObject(json["phone_num"].stringValue, forKey: "PhoneNo")
                                                        defaults.synchronize()
                                                    }
                                                    if json["home_address"].stringValue != ""{
                                                        SignifyUserController.sharedInstance.currentUser.homeAddress = json["home_address"].stringValue
                                                        defaults.setObject(json["home_address"].stringValue, forKey: "HomeAddress")
                                                        defaults.synchronize()
                                                    }
                                                    if json["lastname"].stringValue != "unknown"{
                                                        SignifyUserController.sharedInstance.currentUser.lastName = json["last_name"].stringValue
                                                        print(json["last_name"].stringValue)
                                                        defaults.setObject(json["last_name"].stringValue, forKey: "LastName")
                                                        defaults.synchronize()
                                                    }
                                                }else{
                                                    print("log in failure")
                                                }
                                            })
                                        }
                                        self.navigationController?.pushViewController(welcomepageviewcontroller, animated: true)
                                    }
                                    else {
                                        print(error)
                                    }
                                })
                                
                                    self.activityIndicator.stopAnimating()
                                    self.activityIndicator.hidden = true
                                }
                                
                            }
                        })

                    }
                    
                
            
        
        }

    }

}
