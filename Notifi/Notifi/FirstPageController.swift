//
//  WelcomeViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/21/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FirstPageController: UIViewController{
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var ItemIndex: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, picture.type(large)"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if error == nil {
            self.profileImage.round()
            let url = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url")
            if url != nil {
                let picurl = NSURL(string: url! as! String)
                let data = NSData(contentsOfURL: picurl!)
                self.profileImage.image = UIImage(data: data!)
            }
                if let firstname = result.valueForKey("first_name") as? String {
                    self.welcomeLabel.text = "Welcome " + firstname + "!"
                }
                
            }
        })

        
    }
    override func viewDidDisappear(animated: Bool) {
       // navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addGradient(from: .notifiTeal(), to: .notifiDarkTeal())
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
