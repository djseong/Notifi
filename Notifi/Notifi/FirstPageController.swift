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
import ImageLoader

class FirstPageController: UIViewController{
    var tempimage: UIImageView = UIImageView()
    var templabel:String = ""
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var ItemIndex: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print(templabel)
        profileImage.image = tempimage.image
        profileImage.round()
        welcomeLabel.text = templabel
        /*let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "first_name, picture.type(large)"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if error == nil {
                self.profileImage.round()
                let url = result.valueForKey("picture")?.valueForKey("data")?.valueForKey("url")
                if url != nil {
                    let picurl = NSURL(string: url! as! String)
                    self.profileImage.load(picurl!, placeholder: UIImage(), completionHandler: { (url, image, error, cache) in
                        print(error)
                    })
//                    let data = NSData(contentsOfURL: picurl!)
//                    self.profileImage.load(picurl!) //= UIImage(data: data!)
                }
                if let firstname = result.valueForKey("first_name") as? String {
                    self.welcomeLabel.text = "Welcome " + firstname + "!"
                }
                
            }
        })*/
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
