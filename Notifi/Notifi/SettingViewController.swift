//
//  SettingViewController.swift
//  Notifi
//
//  Created by David Xu on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import CoreLocation

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    let locationManager = CLLocationManager()
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBAction func switchTurned(sender: UISwitch) {
        if sender.on{
            let alert = UIAlertController(title: "Your GPS is on", message: "By turning on the GPS, your friends will be able to see you on the map", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay, I see", style: .Cancel, handler: nil)
            locationManager.requestAlwaysAuthorization()
            let location_status = CLLocationManager.authorizationStatus()
            defaults.setObject(true, forKey: "UseMyLocation")
            defaults.synchronize()
            if location_status == CLAuthorizationStatus.AuthorizedAlways{
            SignifyUserController.sharedInstance.currentUser.useLocation = true
            locationSwitch = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.updateLocation), userInfo: self, repeats: true)
            }else{
                print("We are not allowed to use your location")
            }
            
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Your GPS is off", message: "By turning off the GPS, your friends will not be able to see you on the map", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay, I see", style: .Cancel, handler: nil)
            SignifyUserController.sharedInstance.currentUser.useLocation = false
            locationSwitch.invalidate()
            defaults.setObject(false, forKey: "UseMyLocation")
            defaults.synchronize()
            APIServiceController.sharedInstance.disableLocation()
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var gpsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchGPS: UISwitch!
    var settingArray = ["My Profile","Emergency Contact", "Edit Friend List","Edit Signifi Friend List", "", "Logout"]
    var locationSwitch = NSTimer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "icon_settings_full.png"))
        self.view.backgroundColor = UIColor.nightlyBackgroundGrey()
        
        //set up tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.nightlyBackgroundGrey()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingcell")
        
        //set up switch
        switchGPS.onTintColor = UIColor.notifiTeal()
        switchGPS.backgroundColor = UIColor.noticeGrey()
        switchGPS.transform = CGAffineTransformMakeScale(2.0, 2.0)
        switchGPS.layer.cornerRadius = 16
        
        switchGPS.on = SignifyUserController.sharedInstance.currentUser.useLocation
        
        gpsLabel.font = UIFont(name: "Montserrat-UltraLight", size: 20)

    }

    func updateLocation(){
        let apiService = APIService()
        let locationManager = CLLocationManager()
        let latitude = Double((locationManager.location?.coordinate.latitude)!)
        let longitude = Double((locationManager.location?.coordinate.longitude)!)
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/location"),method:"POST",parameters:["latitude":String(latitude),"longitude":String(longitude)])
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print(json)
                print(responseCode)
            }
            else {
                print(responseCode)
                print("error in updating location")
            }
        })
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCellWithIdentifier("settingcell",forIndexPath: indexPath)
        if indexPath.row != 4 {
            newCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
            newCell.backgroundColor = UIColor.nightlyBackgroundGrey()
            let myfont = UIFont(name: "Montserrat-UltraLight", size: 30)
            newCell.textLabel?.text = settingArray[indexPath.row]
            newCell.textLabel?.textColor = UIColor.noticeGrey()
            newCell.textLabel?.font = myfont
        return newCell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            navigationController?.pushViewController(MyProfileViewController(), animated: true)
        }
        else if indexPath.row == 1{
            navigationController?.pushViewController(MyProfileViewController(), animated: true)
        }
        else if indexPath.row == 2 {
            navigationController?.pushViewController(FriendTableViewController(), animated: true)
        }
        else if indexPath.row == 3{
            navigationController?.pushViewController(NotifyFriendListViewController(), animated: true)
        }
        else if indexPath.row == 5 {
            self.fbLogout()
        }
//        else if indexPath.row == 6 {
//            let alert = UIAlertController(title: "LOL", message: "",
//                                          preferredStyle: UIAlertControllerStyle.Alert)
//            let alertAction = UIAlertAction(title: "Okay", style: .Cancel, handler: { (action) in
//            })
//            alert.addAction(alertAction)
//            self.presentViewController(alert, animated: true, completion: nil)
//
//        }
    }
    
    
    // Facebook
    func fbLogout() {
        let fbLogoutManager = FBSDKLoginManager()
        fbLogoutManager.logOut()
        
        // Reset nsuser
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentuserfbId")
        defaults.removeObjectForKey("UseMyLocation")
        defaults.synchronize()
        APIServiceController.sharedInstance.logout()
        print("User Logged Out")
        
        // Go back to onboarding
        let onboardingcontroller = OnboardingViewController(nibName: "OnboardingViewController", bundle: nil)
        let navigationcontroller = UINavigationController(rootViewController: onboardingcontroller)
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = navigationcontroller
        
        // Set up navigation bar
        navigationcontroller.navigationBar.barTintColor = UIColor.blackColor()
        navigationcontroller.navigationBar.barStyle = UIBarStyle.Black
        navigationcontroller.navigationBar.tintColor = UIColor.whiteColor()
    }


    }
