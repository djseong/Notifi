//
//  NightlyViewController.swift
//  Notifi_siqingXu
//
//  Created by David Xu on 7/18/16.
//  Copyright © 2016 David Xu. All rights reserved.

import UIKit
import Firebase
import FirebaseMessaging

class NightlyViewController: UIViewController {

    @IBOutlet weak var safeButton: UIButton!
    @IBOutlet weak var attentionButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    

    let topLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //check if we can send user's location
        let location_status = CLLocationManager.authorizationStatus()
        if SignifyUserController.sharedInstance.currentUser.useLocation{
        if location_status == CLAuthorizationStatus.AuthorizedAlways{
            SignifyUserController.sharedInstance.currentUser.useLocation = true
            SignifyUserController.sharedInstance.locationSwitch = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.updateLocation), userInfo: self, repeats: true)
        }else{
            print("We are not allowed to use your location")
        }
        }

        
        //change tab bar color to black
        tabBarController?.tabBar.barTintColor = UIColor.blackColor()
        tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
        
        //button setting
        safeButton.layer.borderWidth = 8
        safeButton.layer.borderColor = UIColor.noticeGreen().CGColor
        safeButton.titleLabel?.tintColor = UIColor.noticeGreen()
        
        attentionButton.layer.borderWidth = 8
        attentionButton.layer.borderColor = UIColor.noticeButtonYellow().CGColor
        attentionButton.titleLabel?.tintColor = UIColor.noticeYellow()
        
        helpButton.layer.borderWidth = 8
        helpButton.layer.borderColor = UIColor.noticeRed().CGColor
        helpButton.titleLabel?.tintColor = UIColor.noticeRed()

        //create a setting button
        let settingButton = UIBarButtonItem(image: UIImage(named:"icon_settings_stroke.png"), style: .Done, target: self, action:  #selector(self.settingPressed(_:)))
            //UIBarButtonItem(title: "Settings", style: .Done, target: self, action: #selector(self.settingPressed(_:)))
        settingButton.tintColor = UIColor.whiteColor()
        navigationItem.setRightBarButtonItem(settingButton, animated: true)
        if StatusController.sharedInstance.currentStatus.state == .Safe{
        navigationItem.title = "Your status: Safe"
        }else if StatusController.sharedInstance.currentStatus.state == .Attention{
            navigationItem.title = "Your status: Need Attention"
        }else if StatusController.sharedInstance.currentStatus.state == .Help{
            navigationItem.title = "Your status: Need Help"
        }
        
        //change the back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Done, target: self, action: nil)
        
        
        //set up navigation bar color to balck and status bar to dark color mode
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController?.navigationBar.barStyle = UIBarStyle.Black
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        }
    override func viewWillAppear(animated: Bool) {
        //check user status
        if StatusController.sharedInstance.currentStatus.state == .Safe{
            navigationItem.title = "Your status: Safe"
        }else if StatusController.sharedInstance.currentStatus.state == .Attention{
            navigationItem.title = "Your status: Need Attention"
        }else if StatusController.sharedInstance.currentStatus.state == .Help{
            navigationItem.title = "Your status: Need Help"
        }
    }
    
    func settingPressed(sender:UIBarButtonItem){
        self.navigationController?.pushViewController(SettingViewController(), animated: true)
    }
    
    @IBAction func safePressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Safe)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
        APIServiceController.sharedInstance.updateState(.Safe)
        
    }
    @IBAction func attentionPressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Attention)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
         APIServiceController.sharedInstance.updateState(.Attention)
    }
    @IBAction func helpPressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Help)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
        APIServiceController.sharedInstance.updateState(.Help)
        }
    //call the update location here because user might not go into the setting page but still can update their location 
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

}
