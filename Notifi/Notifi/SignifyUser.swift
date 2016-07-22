//
//  User.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
import Firebase

class SignifyUser:  NSObject, MKAnnotation{
    var lastName: String
    var firstName: String

    
    var homeAddress:String
    var cellPhone: String

    var profilePhotoString: String?
    var friends = [SignifyUser]()
    var currstatus : State = .Safe
    var statusHistory : [Status] = []
    var fbId:String?
    
    var emergencyContactUser: SignifyUser?// = SignifyUser(lastName: "My", firstName: "Mom")
    
    // This is the same as the firstName, but needs to conform to MKAnnotationProtocol
    var title: String?
    
    // This is also needed. Set to some random default value 
    var coordinate : CLLocationCoordinate2D
    
    var firebaseToken:String?   {
        
        let refreshedToken = FIRInstanceID.instanceID().token()
        return refreshedToken
    }
    
   // var emergencyContactUser: SignifyUser = SignifyUser(lastName: "My", firstName: "Mom")

   // various inits  
    
    init(lastName:String, firstName:String,imageString:String, fbId:String){
        self.lastName = lastName
        self.firstName = firstName
        self.title = firstName
        self.profilePhotoString = imageString
        self.fbId = fbId

        self.cellPhone = ""
        self.homeAddress = ""
        self.coordinate =  CLLocationCoordinate2D(latitude: -34, longitude: 18.5)

        
    }
    
    
}