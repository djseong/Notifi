//
//  EditProfileViewController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var homeAddressField: UITextField!
    @IBOutlet weak var cellPhoneField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    var navBar = UINavigationBar()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.round()
        navBar.frame = CGRectMake(0, 0, self.view.frame.width, 60)
        navBar.barTintColor = UIColor.blackColor()
        navBar.barStyle = .Black
        navBar.tintColor = UIColor.whiteColor()
        self.view.addSubview(navBar)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
