//
//  CustomizedTabBarViewController.swift
//  Notifi
//
//  Created by David Xu on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class CustomizedTabBarViewController: UITabBarController {

    @IBOutlet weak var customTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var tabFrame:CGRect = self.tabBar.frame
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
        self.tabBar.frame = tabFrame
    }

}
