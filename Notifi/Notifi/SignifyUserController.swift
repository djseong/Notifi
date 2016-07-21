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
    
    // Ns if we need this but keeping it for dummy variables
    var SignifyFriendList : [SignifyUser] = []
    
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
    
    
    
    func send ()    {
        
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string:"https://fcm.googleapis.com/fcm/send")!)
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue("key=AIzaSyDCLEwBwuM7CmBUePfGHxN8RbxdcHRq5rM", forHTTPHeaderField: "Authorization")
        let data = ["alert":"alert_value"]
        let params = ["data":data, "to": "eXD6rxAGHFg:APA91bG7kQYiPrHP_fnITm1cF01aPDyewQYxUy8iVnMKetzBzU5LdWx5vWieNQ0nw1ZiC7itWUvCruLGqqbU7r7Jcg1dr1iIdejr8uvZdIC8WeRJMxPVKcsS4D8frl2yBDn9gWT0N5h0"]
        
        let jsonS = self.JSONStringify(params, prettyPrinted: true)
        mutableURLRequest.HTTPBody = jsonS.dataUsingEncoding(NSUTF8StringEncoding)
        let manager = Manager.sharedInstance // or create a new one
        let request = manager.request(mutableURLRequest)
        request.responseString { returnedData -> Void in  //execute the request and give us JSON response data
            
            //the web service is now done. Remove the loading overlay
            //            presentingViewController?.removeLoadingOverlay()
            print(returnedData)
            //Handle the response from the web service
            let success = returnedData.result.isSuccess
            if (success)    {

            print("success")
            if (success)    {
                
                let json = JSON(returnedData.result.value!)
                let serverResponseCode = returnedData.response?.statusCode
//                completion(serverResponseCode!,json)
                
            }   else    { //response code is nil
                
            }
        }

        
    }
    }
    
    func sendNote(receivers:[String], alert:String, key:String) {
        
        for receiverKey in receivers    {
            //send the push note
            
            // build request
            let headers = ["Authorization":"key=\("AIzaSyDCLEwBwuM7CmBUePfGHxN8RbxdcHRq5rM")", "Content-Type":"application/json"]
            let data = ["data":["alert":"alert_value"]]
            let params = ["data":data, "to": "fWpnG1kI9MA:APA91bHQZlJ6G-8nuVm9eblA_ZmsjM4vm8iUYglvE8mZy0egiYfYb5UUTn95tOKnYiU2tkhGHZu8nWjogAzRx_rOO1TbF2hoS-CqWOffCjD9qlI0HGGYw6B8drV0gZIegzs5uHFCnRsl"]
            
            let request = Alamofire.request(.POST, NSURL(string:"https://fcm.googleapis.com/fcm/send/")!, parameters: params as! [String : AnyObject], encoding: .URL, headers: headers)
            print (request)
            
            request.responseJSON { returnedData -> Void in  //execute the request and give us JSON response data
                
                //the web service is now done. Remove the loading overlay
                //            presentingViewController?.removeLoadingOverlay()
                
                //Handle the response from the web service
                let success = returnedData.result.isSuccess
                if (success)    {
                    
                    var json = JSON(returnedData.result.value!)
                    let serverResponseCode = returnedData.response!.statusCode //since the web service was a success, we know there is a .response value, so we can request the value gets unwrapped with .response!
                    
                    
                    
                    //execute the completion function specified by the class that called this executeRequest function
                    //the
                    
                    
                }   else    {
                    print ()
                }
            }

            
        }
        
    }
    
    func JSONStringify(value: AnyObject, prettyPrinted: Bool = false) -> String {
        //     var options = prettyPrinted
        if NSJSONSerialization.isValidJSONObject(value) {
            if let data = try? NSJSONSerialization.dataWithJSONObject(value, options: NSJSONWritingOptions.PrettyPrinted) {
                if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    return string as String
                }
            }
        }
        return ""
    }
    
    
    
    // this func is solely for dummy users for now
    
    
    func getFriendsList() -> [SignifyUser] {
        
        let s1 : Status = Status(state: .Safe, time: "3 minutes ago", user: "Tobin")
        let s2 : Status = Status(state: .Attention, time: "6 minutes ago", user: "Bobby")
        let s3 : Status = Status(state: .Help, time: "10 minutes ago", user: "Tobin's cat")
        
        
        let user1 = SignifyUser(lastName: "Bell", firstName: "Tobin")
        user1.currstatus = .Help
        user1.cellPhone = "2035510306"
        user1.picture = UIImage(named: "testAlpaca")
        user1.statusHistory = [s1, s1, s2, s3]
        user1.coordinate = CLLocationCoordinate2D(latitude: -34.0021, longitude: 18.4987)
        
        let user2 = SignifyUser(lastName: " ", firstName: "Tobin's cat")
        user2.currstatus = .Safe
        user2.cellPhone = "2035510306"
        user2.statusHistory = [s1, s1, s1]
        user2.coordinate = CLLocationCoordinate2D(latitude: -34.0018, longitude: 18.4980)
        
        
        
        
        
        
        
        SignifyFriendList.append(user1)
        SignifyFriendList.append(user2)
    //    userList.append(user3)
    //    userList.append(user4)
    //    userList.append(user5)
        
        
        return SignifyFriendList
        
    }

}