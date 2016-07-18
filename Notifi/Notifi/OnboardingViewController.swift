//
//  OnboardingViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set colors
        self.view.backgroundColor = UIColor.notifiGray()
        self.titleLabel.textColor = UIColor.whiteColor()
        
        // Button segues
        registerButton.addTarget(self, action: #selector(registerView), forControlEvents: .TouchUpInside)
        loginButton.addTarget(self, action: #selector(loginView), forControlEvents: .TouchUpInside)
        
        // navigation controller
        navigationController?.navigationBar.barStyle = UIBarStyle.Black

        
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addGradient(from: .notifiGreen(), to: .notifiDarkGreen())
    }
    
    func registerView() {
        let registerviewcontroller = RegisterViewController(nibName: "RegisterViewController", bundle: nil)
        self.navigationController?.pushViewController(registerviewcontroller, animated: true)
    }
    
    func loginView() {
        let loginviewcontroller = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginviewcontroller, animated: true)
    }

}
