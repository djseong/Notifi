//
//  EditProfileViewController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController,UITextFieldDelegate {
    let usePersonalProfile = SignifyUserController.sharedInstance.UsePersonalProfile
    let currentUser = SignifyUserController.sharedInstance.currentUser
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var homeAddressField: UITextField!
    @IBOutlet weak var cellPhoneField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        profileImage.round()
        let url = currentUser.profilePhotoString
        let picurl = NSURL(string: url!)
        profileImage.load(picurl!)
        
        if usePersonalProfile{
        self.firstNameField.text = currentUser.firstName
        self.lastNameField.text = currentUser.lastName
        self.cellPhoneField.text = currentUser.cellPhone
        self.homeAddressField.text = currentUser.homeAddress
        }else{
            self.firstNameField.text = currentUser.emerFirstName
            self.lastNameField.text = currentUser.emerLastName
            self.cellPhoneField.text = currentUser.emerCellPhone
            self.homeAddressField.hidden = true
            self.profileImage.hidden = true
        }
       
        //delegate
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.cellPhoneField.delegate = self
        self.homeAddressField.delegate = self
    }

    
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        if usePersonalProfile{
        //set current version
        SignifyUserController.sharedInstance.currentUser.lastName = lastNameField.text!
        SignifyUserController.sharedInstance.currentUser.cellPhone = cellPhoneField.text!
        SignifyUserController.sharedInstance.currentUser.firstName = firstNameField.text!
        SignifyUserController.sharedInstance.currentUser.homeAddress = homeAddressField.text!
        
        //set for remote database
        APIServiceController.sharedInstance.updateProfile(["frist_name":firstNameField.text!,"last_name":lastNameField.text!, "phone_num":cellPhoneField.text!,"home_address":homeAddressField.text!])
        
        //set for defaults
        defaults.setObject(cellPhoneField.text!, forKey: "PhoneNo")
        defaults.setObject(homeAddressField.text!, forKey: "HomeAddress")
        defaults.setObject(lastNameField.text!, forKey: "LastName")
        defaults.synchronize()
        }else{
             //set current version
            SignifyUserController.sharedInstance.currentUser.emerFirstName = firstNameField.text!
            SignifyUserController.sharedInstance.currentUser.emerLastName = lastNameField.text!
            SignifyUserController.sharedInstance.currentUser.emerCellPhone = cellPhoneField.text!
            //set for remote database
            APIServiceController.sharedInstance.updateProfile(["emer_phone_num":cellPhoneField.text!])
            //set for default
            defaults.setObject(cellPhoneField.text!, forKey: "EmerPhoneNo")
            defaults.setObject(firstNameField.text!, forKey: "EmerFirstName")
            defaults.setObject(lastNameField.text!, forKey: "EmerLastName")
            defaults.synchronize()
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    @IBAction func cancelButtonPressed(sender: UIButton) {
         self.dismissViewControllerAnimated(true, completion: nil)
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    func textFieldDidEndEditing(textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:NSTimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }

    

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
