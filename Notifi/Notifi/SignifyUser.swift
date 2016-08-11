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
    var useLocation: Bool
    var useNotifyFriendList: Bool
    var emerFirstName: String
    var emerLastName: String
    var emerCellPhone: String
    var notifyFriendList: [String] = []
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
        self.useLocation = false
        self.useNotifyFriendList = false
        self.cellPhone = ""
        self.homeAddress = ""
        self.emerFirstName = ""
        self.emerLastName = ""
        self.emerCellPhone = ""
        self.coordinate =  CLLocationCoordinate2D(latitude: 800, longitude: 800)

        
    }
    
    
}