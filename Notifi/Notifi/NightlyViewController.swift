//
//  NightlyViewController.swift
//  Notifi_siqingXu
//
//  Created by David Xu on 7/18/16.
//  Copyright © 2016 David Xu. All rights reserved.

import UIKit

class NightlyViewController: UIViewController {

    @IBOutlet weak var safeButton: UIButton!
    @IBOutlet weak var attentionButton: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    let topLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up navigation bar color to balck and status bar to dark color mode
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        //change tab bar color to black
        tabBarController?.tabBar.barTintColor = UIColor.blackColor()
        tabBarController?.tabBar.tintColor = UIColor.whiteColor()
        
        //create a setting button
        let settingButton = UIBarButtonItem(title: "Settings", style: .Done, target: self, action: #selector(self.settingPressed(_:)))
        settingButton.tintColor = UIColor.whiteColor()
        navigationItem.setRightBarButtonItem(settingButton, animated: true)
        navigationItem.title = "Your status: Safe"
        
        }
    func settingPressed(sender:UIBarButtonItem){
        print("pressed")
    }
    @IBAction func safePressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Safe)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
        
    }
    @IBAction func attentionPressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Attention)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
    }
    @IBAction func helpPressed(sender: UIButton) {
        StatusController.sharedInstance.changeCurrentState(State.Help)
        self.presentViewController(NoticeViewController(), animated: true, completion: nil)
    }

}
