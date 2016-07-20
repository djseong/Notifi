//
//  MyProfileViewController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var homeAddressLabel: UILabel!
    @IBOutlet weak var cellPhoneNumberLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.nightlyBackgroundGrey()
        profileImage.round()
        profileImage.backgroundColor = UIColor.brownColor()
        self.navigationItem.title = "My Profile"
        //let editButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: #selector(self.editPressed(_:)))
        //self.navigationItem.rightBarButtonItem = editButton
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func editPressed(sender: UIBarButtonItem){
        self.navigationController?.presentViewController(MyProfileViewController(), animated: false, completion: nil)
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
