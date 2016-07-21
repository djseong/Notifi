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

        
        //change tab bar color to black
        tabBarController?.tabBar.barTintColor = UIColor.blackColor()
        tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
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

        //message.subscribeToTopic("/topics/cheese")
        SignifyUserController.sharedInstance.send("I am Safe")
        print(WebDatabase.sharedInstance.getUserName())
        
    }
    @IBAction func attentionPressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Attention)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
         SignifyUserController.sharedInstance.send("I need your attention!")
        WebDatabase.sharedInstance.resgisterUser("asdf@rewq.com", firstName: "Julian", lastName: "hel", pushId: "asdf")
        
    }
    @IBAction func helpPressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Help)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
        WebDatabase.sharedInstance.addContact("515948294@qq.com", onCompletion: {boValue, newContact in
            if boValue{
                var key:String?
                WebDatabase.sharedInstance.findCurrentUserKey({keyIn in key = keyIn
                    let ref = FIRDatabase.database().reference()
                    print(key)
                    ref.child("ios_users").child(key!).child("contacts").setValue(newContact)
                
                })
            }else{
                print("failed")
            }
        
        })
    }

}
