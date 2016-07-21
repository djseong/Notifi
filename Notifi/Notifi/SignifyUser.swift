//
//  User.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import Firebase

class SignifyUser{
    var lastName: String
    var firstName: String
    var emailAddress: String
    var homeAddress:String?
    var cellPhone: String
    var profilePhoto: UIImage?
    var friends = [SignifyUser]()
    var emergencyContactUser: SignifyUser?// = SignifyUser(lastName: "My", firstName: "Mom")
    var firebaseToken:String?   {
        
        let refreshedToken = FIRInstanceID.instanceID().token()
        return refreshedToken
    }
    
    init(lastName:String, firstName:String){
        self.lastName = lastName
        self.firstName = firstName
        self.emailAddress = ""
        self.cellPhone = ""
        
    }
    
}