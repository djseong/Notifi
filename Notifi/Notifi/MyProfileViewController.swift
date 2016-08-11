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
    var usePersonalProfile = SignifyUserController.sharedInstance.UsePersonalProfile

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
        
        if usePersonalProfile{
            self.navigationItem.title = "My Profile"
        }else{
            self.navigationItem.title = "Emergency Contact"
            profileImage.hidden = true
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        //if the user want to know the personal profile
        if usePersonalProfile{
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
        }//if the user want to know the emergency contact
        else{
            if currentUser.emerFirstName != ""{
            firstNameLabel.text = currentUser.emerFirstName
            }else{
                firstNameLabel.text = "First Name"
            }
            if currentUser.emerLastName != ""{
                lastNameLabel.text = currentUser.emerLastName
            }else{
                lastNameLabel.text = "Last Name"
            }
            if currentUser.emerCellPhone != ""{
                cellPhoneNumberLabel.text = currentUser.emerCellPhone
            }else{
                cellPhoneNumberLabel.text = "Cell Phone Number"
            }
            homeAddressLabel.text = ""
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func editPressed(sender: UIBarButtonItem){
        self.navigationController?.presentViewController(EditProfileViewController(), animated: true, completion: nil)
    }
    

   

}
