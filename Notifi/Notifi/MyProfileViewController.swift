//
//  MyProfileViewController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {
    var currentUser = SignifyUserController.sharedInstance.currentUser

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var homeAddressLabel: UILabel!
    @IBOutlet weak var cellPhoneNumberLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(self.editPressed(_:)))
        self.navigationItem.setRightBarButtonItem(editButton, animated: true)
        self.view.backgroundColor = UIColor.nightlyBackgroundGrey()
        profileImage.round()
        profileImage.backgroundColor = UIColor.brownColor()
        let url = currentUser.profilePhotoString
        let picurl = NSURL(string: url!)
        profileImage.load(picurl!)
        
        self.navigationItem.title = "My Profile"
        
    }
    override func viewWillAppear(animated: Bool) {
        if currentUser.homeAddress != ""{
            homeAddressLabel.text = currentUser.homeAddress
        }else{
            homeAddressLabel.text = "Home Address"
        }
        
        if currentUser.cellPhone != ""{
            cellPhoneNumberLabel.text = currentUser.cellPhone
        }else{
            cellPhoneNumberLabel.text = "Cell Phone Number"
        }
        firstNameLabel.text = currentUser.firstName
        lastNameLabel.text = currentUser.lastName

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func editPressed(sender: UIBarButtonItem){
        self.navigationController?.presentViewController(EditProfileViewController(), animated: true, completion: nil)
    }
    

   

}
