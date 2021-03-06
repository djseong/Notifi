//
//  APIServiceController.swift
//  Notifi
//
//  Created by David Xu on 8/6/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIServiceController{
    static var sharedInstance = APIServiceController()
    let apiService = APIService()
    //all the api calls which the app can use anywhere
    func updateDeviceToken(device_token: String){
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/device_token"),method:"POST",parameters:["device_token":device_token])
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print(json)
                print(responseCode)
            }
            else {
                print(responseCode)
                print("error in changing device token")
            }
        })

    }
    
    func disableLocation(){
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/dislocation"),method:"POST",parameters:nil)
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print(json)
                print(responseCode)
            }
            else {
                print(responseCode)
                print("error in disable location profile")
            }
        })
    }
    
    func updateProfile(parameters:[String:String]){
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/update_profile"),method:"POST",parameters:parameters)
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print(json)
                print(responseCode)
            }
            else {
                print(responseCode)
                print("error in updating profile")
            }
        })
    }
    
    func updateState(state: State){
        var state_string: String
        if state == .Safe{ state_string = "safe"
        }else if state == .Attention{ state_string = "attention"
        }else{ state_string = "help"}
        if SignifyUserController.sharedInstance.currentUser.useNotifyFriendList{
            for friend in SignifyUserController.sharedInstance.currentUser.notifyFriendList{
                let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/state_single"),method:"POST",parameters:["state":state_string, "facebook_id": friend])
                apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
                    if responseCode/100 == 2{
                        print(json)
                    }
                    else {
                        print(responseCode)
                         print(json)
                    }
                })

            }
            let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/state_single2"),method:"POST",parameters:["state":state_string])
            apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
                if responseCode/100 == 2{
                    print(json)
                }
                else {
                    print(responseCode)
                    print(json)
                }
            })

        }else{
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/admin/state"),method:"POST",parameters:["state":state_string])
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                //print(json)
            }
            else {
                //print(responseCode)
               // print(json)
            }
        })
        }
    }
    func populateFriendList(){
        var friendList = [SignifyUser]()
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/friendship/getall"),method:"GET",parameters:nil)
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print(json)
                for (_,friend) in json{
                    //game = [string, json]
                    var facebook_id = ""
                    var lastName = "Unknown"
                    var firstName = "Unknown"
                    var imageString = ""
                    var friend_state: State = .Safe
                    if friend["facebook_id"].stringValue != "" {facebook_id = friend["facebook_id"].stringValue }
                    print(facebook_id)
                    if friend["firstname"].stringValue != ""{firstName = friend["firstname"].stringValue}
                    print(firstName)
                    if friend["profile_pic"].stringValue != ""{imageString = friend["profile_pic"].stringValue}
                    if friend["lastname"].stringValue != ""{lastName = friend["lastname"].stringValue}
                    if friend["state"].stringValue != ""{
                        if friend["state"].stringValue == "safe"{ friend_state = .Safe}
                        else if friend["state"].stringValue == "attention"{friend_state = .Attention}
                        else if friend["state"].stringValue == "help"{friend_state = .Help}
                    }
                    let newFriend = SignifyUser(lastName: lastName, firstName: firstName, imageString: imageString, fbId: facebook_id)
                    newFriend.cellPhone = friend["phone_num"].stringValue
                    newFriend.homeAddress = friend["home_address"].stringValue
                    newFriend.currstatus = friend_state
                    newFriend.emerCellPhone = friend["emer_phone_num"].stringValue
                    friendList.append(newFriend)
                   
                }
                SignifyUserController.sharedInstance.currentUser.friends = friendList
                //print(json.count)
            }
            else {
                //print(responseCode)
                //print(json)
                }
        })
    }
    
    func sendRequest(facebook_id: String){
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/friendship/push_request"),method:"POST",parameters:["facebook_id":facebook_id])
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print("successfully send request")
            }
            else {
                print(responseCode)
                print(json)
                
            }
        })
    }
    func logout(){
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/access/logout"),method:"GET",parameters:nil)
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                print(json)
            }
            else {
                print(responseCode)
                print(json)
                
            }
        })

    }
            
}