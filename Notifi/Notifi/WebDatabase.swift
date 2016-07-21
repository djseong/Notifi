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
    func resgisterUser(fbId:String, firstName:String, lastName:String, pushId:String) {
//        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: { (data) in
//            let fullDatabase = data.value as! [String : AnyObject]
//            for user in fullDatabase{
//                            }
//            
//        }){ (error) in
//            print(error.localizedDescription)
//        }
        
        let key = ref.child("ios_users").childByAutoId().key
        let user = ["fbId": fbId,
                    "contacts": [],
                    "first_name": firstName,
                    "last_name": lastName,
                    "push_note_id":pushId]

        let childUpdates = ["/ios_users/\(key)": user]
        ref.updateChildValues(childUpdates)

        
    }
    func addContact(friendFbId:String,onCompletion:(boValue:Bool,newContact:[String])->Void){
        

        
        var currentContact = [String]()
        SignifyUserController.sharedInstance.currentUser.fbId = "515948294@qq.com"
        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: {(data) in
            let fullDatabase = data.value as! [String: AnyObject]
            for user in fullDatabase{
                let userFbId = user.1["fbId"] as! String
                if SignifyUserController.sharedInstance.currentUser.fbId == userFbId{
                    print( user.1["contacts"])
                    if let contacts = user.1["contacts"] as? [String]   {
                        
                        currentContact = contacts
                    }   else    {
                        currentContact = []
                    }
                    break
                }
            }
            for user in fullDatabase{
                //let userTuple = user as! (String,AnyObject)
                let userfbId = user.1["fbId"] as! String
                if friendFbId == userfbId{
                    for contact in currentContact{
                        if friendFbId == contact{
                            print("the contact exist")
                            return
                        }
                    }
                    print("find matched user fbId")
                    currentContact.append(friendFbId)
                    onCompletion(boValue: true,newContact: currentContact)
                    return
                }
            }
        }){ (error) in
            print(error.localizedDescription)
        }

    }
    
    func findCurrentUserKey(onCompl: (String?)->Void) {

        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: { (data) in
            let fullDatabase = data.value as! [String : AnyObject]
            for user in fullDatabase{
               
                let userTuple = user
                print(userTuple.0)
                let fbId = userTuple.1["fbId"]!!
                if SignifyUserController.sharedInstance.currentUser.fbId == fbId as! String{
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