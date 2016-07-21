//
//  dummyUser.swift
//  notifiSam
//
//  Created by Sam on 7/18/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import Foundation
import MapKit




// Should the user model and the model for the MKAnnotation be the same thing?

class User : NSObject, MKAnnotation {
    
    
    var title : String?
    var coordinate : CLLocationCoordinate2D
    var picture: UIImage?
    var currstatus : State = .Safe
    var address1: String = "123 Apple Street"
    var address2: String = "NYC, NY 10002"
    var phone : String = "2035510306"
    var statusHistory: [Status] = []
    var emergencyPhone : String = "2035510306"
    
    
    init(title : String, latitude: Double, longitude : Double, address1: String, address2: String, phone: String) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.address1 = address1
        self.address2 = address2
        self.phone = phone
    }
    
    init(title : String, coordinate: CLLocationCoordinate2D, address1: String, address2: String, phone: String) {
        self.title = title
        self.coordinate = coordinate
        self.address1 = address1
        self.address2 = address2
        self.phone = phone
    }
    
   
    
}


class UserController {
    
    static let sharedInstance = UserController()
    private init() {}
    
    var userList : [User] = []
    
    
    func getJournals() -> [User] {
        
        let s1 : Status = Status(state: .Safe, time: "3 minutes ago", user: "Tobin")
        let s2 : Status = Status(state: .Attention, time: "6 minutes ago", user: "Bobby")
        let s3 : Status = Status(state: .Help, time: "10 minutes ago", user: "Tobin's cat")

         
        let user1 = User(title: "Amy", coordinate: CLLocationCoordinate2D(latitude: -33.9350, longitude: 18.3890), address1: "123 Apple Street", address2: "NYC, NY 06607", phone: "2035510306" )
        user1.statusHistory = [s1, s1, s1]
        
        let user2 = User(title: "Tia", coordinate: CLLocationCoordinate2D(latitude: -33.9350, longitude: 18.37), address1: "321 Orange Street", address2: "NYC, NY 06607", phone: "2035510306")
        user2.statusHistory = [s1, s2, s3]
        
        
        let user3 = User(title: "Robert", coordinate: CLLocationCoordinate2D(latitude: -33.93, longitude: 18.3890), address1: "456 Port Street", address2: "NYC, NY 06607", phone: "2035510306")
        user3.currstatus = .Attention
        user3.statusHistory = [s1]
        
        
        let user4 = User(title: "Tobin", coordinate: CLLocationCoordinate2D(latitude: -33.93, longitude: 18.37), address1: "123 Apple Street", address2: "NYC, NY 06607", phone: "2035510306")
        user4.picture = UIImage(named: "testAlpaca")
        user4.currstatus = .Help
                user4.statusHistory = [s1, s3]
        
        
        
        let user5 = User(title: "Tobin's mom", coordinate: CLLocationCoordinate2D(latitude: -33.92, longitude: 18.379), address1: "123 Apple Street", address2: "NYC, NY 06607", phone: "2035510306")
        user5.statusHistory = [s1]
         
        
         
         userList.append(user1)
         userList.append(user2)
         userList.append(user3)
         userList.append(user4)
         userList.append(user5)
        
        
        return userList
        
    }

    
    
    
}