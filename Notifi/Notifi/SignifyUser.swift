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

    var profilePhoto: UIImage?
    var friends = [SignifyUser]()
    var currstatus : State = .Safe
    var picture: UIImage?
    var statusHistory : [Status] = []
    var fbId:String?
    
    var emergencyContactUser: SignifyUser?// = SignifyUser(lastName: "My", firstName: "Mom")
    
    // This is the same as the firstName, but needs to conform to MKAnnotationProtocol
    var title: String?
    
    // This is also needed. Set to some random default value 
    var coordinate : CLLocationCoordinate2D =  CLLocationCoordinate2D(latitude: -34, longitude: 18.5)
    
    
    var firebaseToken:String?   {
        
        let refreshedToken = FIRInstanceID.instanceID().token()
        return refreshedToken
    }
    
   // var emergencyContactUser: SignifyUser = SignifyUser(lastName: "My", firstName: "Mom")

   // various inits  
    
    init(lastName:String, firstName:String, emailAddress: String){
        self.lastName = lastName
        self.firstName = firstName
        self.title = firstName

        
        self.cellPhone = ""
        self.homeAddress = ""

        
    }
    
    
}