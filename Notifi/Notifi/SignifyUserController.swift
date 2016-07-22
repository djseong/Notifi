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
    

    var currentUser = SignifyUser(lastName: "Siqing", firstName: "Xu", imageString: "0000", fbId: "")
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
    
    
    
    func send (notimessage: String)    {
        
        let mutableURLRequest = NSMutableURLRequest(URL: NSURL(string:"https://fcm.googleapis.com/fcm/send")!)
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        mutableURLRequest.HTTPMethod = "POST"
        mutableURLRequest.setValue("key=AIzaSyDCLEwBwuM7CmBUePfGHxN8RbxdcHRq5rM", forHTTPHeaderField: "Authorization")
        let data = ["body":notimessage, "title":"Hey"]
        let params = ["notification":data, "to": "eXD6rxAGHFg:APA91bG7kQYiPrHP_fnITm1cF01aPDyewQYxUy8iVnMKetzBzU5LdWx5vWieNQ0nw1ZiC7itWUvCruLGqqbU7r7Jcg1dr1iIdejr8uvZdIC8WeRJMxPVKcsS4D8frl2yBDn9gWT0N5h0"]
        
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
                print(json)
                let serverResponseCode = returnedData.response?.statusCode
                
                
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
        
//        
//        let user1 = SignifyUser(lastName: "Bell", firstName: "Tobin")
//        user1.currstatus = .Help
//        user1.cellPhone = "2035510306"
//        user1.picture = UIImage(named: "testAlpaca")
//        user1.statusHistory = [s1, s1, s2, s3]
//        user1.coordinate = CLLocationCoordinate2D(latitude: -34.0021, longitude: 18.4987)
//        user1.homeAddress = "123 Apple Street NYC"
//        
//        let user2 = SignifyUser(lastName: " ", firstName: "Tobin's cat")
//        user2.currstatus = .Safe
//        user2.cellPhone = "8888888888"
//        user2.statusHistory = [s1, s1, s1]
//        user2.coordinate = CLLocationCoordinate2D(latitude: -34.0018, longitude: 18.4980)
//        user2.homeAddress = "123 Apple Street NYC"
//        
//        let user3 = SignifyUser(lastName: " ", firstName: "El Chapo")
//        user3.currstatus = .Attention
//        user3.cellPhone = "2973972297"
//        user3.statusHistory = [s1, s1, s3]
//        user3.coordinate = CLLocationCoordinate2D(latitude: -34.0023, longitude: 18.4970)
//        user3.homeAddress = "333 Orange Ave"
//        
//        let user4 = SignifyUser(lastName: " ", firstName: "Santa Claus")
//        user4.currstatus = .Safe
//        user4.cellPhone = "2035510306"
//        user4.statusHistory = [s1, s1, s1]
//        user4.coordinate = CLLocationCoordinate2D(latitude: -34.0035, longitude: 18.4998)
//        user4.homeAddress = "666 Child Lane"
//        
//        let user5 = SignifyUser(lastName: " ", firstName: "Bob")
//        user5.currstatus = .Safe
//        user5.cellPhone = "2035510306"
//        user5.statusHistory = [s1, s1, s1]
//        user5.coordinate = CLLocationCoordinate2D(latitude: -34.0005, longitude: 18.4968)
//        user5.homeAddress = "123 Apple Street NYC"
        
        
        
        
        
        
        
//        SignifyFriendList.append(user1)
//        SignifyFriendList.append(user2)
//        SignifyFriendList.append(user3)
//        SignifyFriendList.append(user4)
//        SignifyFriendList.append(user5)
        
        
        return SignifyFriendList
        
    }

}