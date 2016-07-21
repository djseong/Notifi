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
        
        
        let key = ref.child("ios_user").childByAutoId().key
        let user = ["email": email,
                    "contacts": [],
                    "first_name": firstName,
                    "last_name": lastName,
                    "push_note_id":pushId]

        let childUpdates = ["/ios_users/\(key)": user]
        ref.updateChildValues(childUpdates)

        
    }
    func addContact(){
        
    }
    
}