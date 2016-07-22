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
    func resgisterUser(fbId:String, firstName:String, lastName:String, profileImage:String) {
        ref.removeAllObservers()
        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: { (data) in
            let fullDatabase = data.value as! [String : AnyObject]
            for user in fullDatabase{
                if fbId == user.1["fbId"] as! String{
                    print("repeat account, log in automatically")
                     return
                }
                    }
            let key = self.ref.child("ios_users").childByAutoId().key
            let user = ["fbId": fbId,
                "contacts": [],
                "first_name": firstName,
                "last_name": lastName,
                "profile_image": profileImage
            ]
            
            let childUpdates = ["/ios_users/\(key)": user]
            self.ref.updateChildValues(childUpdates)
        }){ (error) in
            print(error.localizedDescription)
        }
        self.ref.removeAllObservers()
        
        
    }
    func addContact(friendFbId:String,onCompletion:(boValue:Bool,newContact:[String])->Void){
        

        self.ref.removeAllObservers()
        var currentContact = [String]()
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
                    self.ref.removeAllObservers()
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
                    self.ref.removeAllObservers()
                    return
                }
            
            }
            onCompl(nil)
            self.ref.removeAllObservers()
            
        }){ (error) in
            print(error.localizedDescription)
        }
        
       
    }
    func retriveContact(onCOmpletion onCompletion:([SignifyUser])->Void){
       // self.findCurrentUserKey({(result) in print ("here is current key"); print(result)})
        var returnedUsers = [SignifyUser]()
        var currentContact = [String]()
        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: {(data) in
            let fullDatabase = data.value as! [String: AnyObject]
            for user in fullDatabase{
                let userFbId = user.1["fbId"] as! String
                if SignifyUserController.sharedInstance.currentUser.fbId == userFbId{
                    print(userFbId)
                    print( user.1["contacts"])
                    if let contacts = user.1["contacts"] as? [String]   {
                        
                        currentContact = contacts
                    }   else    {
                        currentContact = []
                    }
                    
                    break
                }
            }
            for contact in currentContact{
                self.ref.removeAllObservers()
                self.retriveUserWithID(contact, onCompletion: {user in
                    if user == nil{
                        print("no contact for this id")
                    }else{
                        returnedUsers.append(user!)
                    }
                    self.ref.removeAllObservers()
                    onCompletion(returnedUsers)
                })
            }
        
        
        })
       

    
    }
    func retriveUserWithID(fbID:String, onCompletion:(signifyUser:SignifyUser?)->Void){
        ref.removeAllObservers()
        var signifyUser:SignifyUser?
        ref.child("ios_users").observeEventType(FIRDataEventType.Value, withBlock: {(data) in
            let fullDatabase = data.value as! [String: AnyObject]
            for user in fullDatabase{
                let userFbId = user.1["fbId"] as! String
                if fbID == userFbId{
            let profileImage = user.1["profile_image"] as! String
                let first_name = user.1["first_name"] as! String
                let last_name = user.1["last_name"] as! String
                 signifyUser = SignifyUser(lastName: last_name, firstName: first_name, imageString: profileImage, fbId: userFbId)
                    onCompletion(signifyUser: signifyUser)
                    self.ref.removeAllObservers()
                    break
                }
            }
            onCompletion(signifyUser: nil)
            self.ref.removeAllObservers()
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
    }
}