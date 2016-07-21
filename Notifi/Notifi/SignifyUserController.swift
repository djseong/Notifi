//
//  SignifyUserController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import FBSDKCoreKit

import FBSDKLoginKit

class SignifyUserController{
    static var sharedInstance = SignifyUserController()
    private init(){
        
    }
    var currentUser = SignifyUser(lastName: "Xu", firstName: "Siqing")
    var currentUserEmail : String = ""
    
    func getLoginDetails() -> String {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if let email = result.valueForKey("email") as? String {
                print("here is email" + email)
                self.currentUserEmail = email
            }
        })
        
        return currentUserEmail
    }
    
}