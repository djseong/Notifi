//
//  SwitchViewController.swift
//  Notifi
//
//  Created by David Xu on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class SwitchViewController: UIViewController {

    @IBOutlet weak var nightlySwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        //change the color of switch and resize the switch
        self.view.backgroundColor = UIColor.nightlyBackgroundGrey()
        nightlySwitch.onTintColor = UIColor.notifiTeal()
        nightlySwitch.backgroundColor = UIColor.noticeGrey()
        nightlySwitch.transform = CGAffineTransformMakeScale(3.0, 3.0)
        nightlySwitch.layer.cornerRadius = 16

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
