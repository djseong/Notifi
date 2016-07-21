//
//  SecondPageViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/21/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addGradient(from: .notifiTeal(), to: .notifiDarkTeal())
    }

    @IBAction func friendTableButtonPressed(sender: CustomButton) {
        let friendtableview = FriendTableViewController(nibName: "FriendTableViewController", bundle: nil)
        navigationController?.pushViewController(friendtableview, animated: true)
    }

}
