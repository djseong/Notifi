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


class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBAction func switchTurned(sender: UISwitch) {
        if sender.on{
            let alert = UIAlertController(title: "Your GPS is on", message: "By turning on the GPS, your friends will be able to see you on the map", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay, I see", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Your GPS is off", message: "By turning off the GPS, your friends will not be able to see you on the map", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay, I see", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var gpsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchGPS: UISwitch!
    var settingArray = ["My profile","Emergency Contact", "Edit Friend List", "", "Logout", "TOBIN <3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "icon_settings_full.png"))
        self.view.backgroundColor = UIColor.nightlyBackgroundGrey()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.nightlyBackgroundGrey()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingcell")
                
        switchGPS.onTintColor = UIColor.notifiTeal()
        switchGPS.backgroundColor = UIColor.noticeGrey()
        switchGPS.transform = CGAffineTransformMakeScale(2.0, 2.0)
        switchGPS.layer.cornerRadius = 16
        
        gpsLabel.font = UIFont(name: "Montserrat-UltraLight", size: 20)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCellWithIdentifier("settingcell",forIndexPath: indexPath)
        if indexPath.row != 3 {
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
        else if indexPath.row == 4 {
            self.fbLogout()
        }
        else if indexPath.row == 5 {
            let alert = UIAlertController(title: "LOL", message: "",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            let alertAction = UIAlertAction(title: "Okay", style: .Cancel, handler: { (action) in
            })
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }
    
    
    // Facebook
    func fbLogout() {
        let fbLogoutManager = FBSDKLoginManager()
        fbLogoutManager.logOut()
        
        // Reset nsuser
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("currentuserfbId")
        defaults.synchronize()
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
