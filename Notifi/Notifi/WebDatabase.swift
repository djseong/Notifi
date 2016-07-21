//
//  WebDatabase.swift
//  Notifi
//
//  Created by David Xu on 7/21/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseInstanceID

class WebDatabase{
    static var sharedInstance = WebDatabase()
    private init(){
    }
    let ref = FIRDatabase.database().reference()
    func getUserName()->[String]{
        var nameStringList = [String]()
        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: { (data) in
            let fullDatabase = data.value as! [String : AnyObject]
            for user in fullDatabase{
//                let userDict = user as! (String,AnyObject)
//                let email = userDict.1["email"]!!
//                let firstName = userDict.1["first_name"]!!
//                print(firstName)
//                let lastName = userDict.1["last_name"]!!
                let userTuple = user as! (String,AnyObject)
                let firstName = userTuple.1["first_name"]!!
                let lastName = userTuple.1["last_name"]!!
                let name = "\(firstName) \(lastName)"
                print(name)
                nameStringList.append(name)
            }
            
        }){ (error) in
            print(error.localizedDescription)
        }
        return nameStringList
    }
    func resgisterUser(email:String, firstName:String, lastName:String, pushId:String) {
//        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: { (data) in
//            let fullDatabase = data.value as! [String : AnyObject]
//            for user in fullDatabase{
//                            }
//            
//        }){ (error) in
//            print(error.localizedDescription)
//        }
        
        let key = ref.child("ios_users").childByAutoId().key
        let user = ["email": email,
                    "contacts": [],
                    "first_name": firstName,
                    "last_name": lastName,
                    "push_note_id":pushId]

        let childUpdates = ["/ios_users/\(key)": user]
        ref.updateChildValues(childUpdates)

        
    }
    func addContact(friendEmail:String,onCompletion:(boValue:Bool,newContact:[String])->Void){
        

        
        var currentContact = [String]()
        SignifyUserController.sharedInstance.currentUser.emailAddress = "515948294@qq.com"
        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: {(data) in
            let fullDatabase = data.value as! [String: AnyObject]
            for user in fullDatabase{
                let userEmail = user.1["email"] as! String
                if SignifyUserController.sharedInstance.currentUser.emailAddress == userEmail{
                    print( user.1["contacts"])
                    currentContact = user.1["contacts"] as! [String]
                    break
                }
            }
            for user in fullDatabase{
                //let userTuple = user as! (String,AnyObject)
                let userEmail = user.1["email"] as! String
                if friendEmail == userEmail{
                    for contact in currentContact{
                        if friendEmail == contact{
                            print("the contact exist")
                            return
                        }
                    }
                    print("find matched user email")
                    currentContact.append(friendEmail)
                    onCompletion(boValue: true,newContact: currentContact)
                    return
                }
            }
        }){ (error) in
            print(error.localizedDescription)
        }

    }
    
    func findCurrentUserKey(onCompl: (String?)->Void) {
//        ref.child("ios_users").child("-KNDoupr0kTzj6SeTaXd").setValue(["last_name":"Xu"])
//        var dependentsJSON:

        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: { (data) in
            let fullDatabase = data.value as! [String : AnyObject]
            for user in fullDatabase{
                //                let userDict = user as! (String,AnyObject)
                //                let email = userDict.1["email"]!!
                //                let firstName = userDict.1["first_name"]!!
                //                print(firstName)
                //                let lastName = userDict.1["last_name"]!!
                let userTuple = user
                print(userTuple.0)
                let email = userTuple.1["email"]!!
                if SignifyUserController.sharedInstance.currentUser.emailAddress == email as! String{
                    let key:String = String("\(userTuple.0)")
                    onCompl(key)
                    return
                }
            
            }
            onCompl(nil)
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
       
    }
    
}