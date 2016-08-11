//
//  SignifyUserController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit

class SignifyUserController{
    static var sharedInstance = SignifyUserController()
    private init(){}
    
   //keep the singleton variables in model controller
    var SignifyFriendList : [SignifyUser] = []
    var UsePersonalProfile: Bool = true

    var currentUser = SignifyUser(lastName: "Siqing", firstName: "Xu", imageString: "0000", fbId: "")
    var locationSwitch = NSTimer()
    var currentUserFbId : String = ""
    


    
    func getLoginDetails() -> String {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in

            if let fbId = result.valueForKey("email") as? String {
                print("here is fbId" + fbId)
                self.currentUserFbId = fbId
            }
        })
        
        return currentUserFbId

    }
    
}