//
//  dummyUser.swift
//  notifiSam
//
//  Created by Sam on 7/18/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import Foundation
import MapKit


enum statusType {
    case Safe
    case Weary
    case Danger
}


class User : NSObject, MKAnnotation {
    
    
    var title : String?
    var coordinate : CLLocationCoordinate2D
    var picture: UIImage?
    var status : statusType = .Safe
    
    init(title : String, latitude: Double, longitude : Double) {
        self.title = title
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(title : String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
   
    
}


class UserController {
    
    static let sharedInstance = UserController()
    private init() {}
    
    var userList : [User] = []
    
    
    func getJournals() -> [User] {
        
         
        let user1 = User(title: "Amy", coordinate: CLLocationCoordinate2D(latitude: -33.9350, longitude: 18.3890))
        let user2 = User(title: "Tia", coordinate: CLLocationCoordinate2D(latitude: -33.9350, longitude: 18.37))
        let user3 = User(title: "Robert", coordinate: CLLocationCoordinate2D(latitude: -33.93, longitude: 18.3890))
        user3.status = .Weary
        let user4 = User(title: "Tobin", coordinate: CLLocationCoordinate2D(latitude: -33.93, longitude: 18.37))
        user4.status = .Danger
        let user5 = User(title: "Tobin's mom", coordinate: CLLocationCoordinate2D(latitude: -33.92, longitude: 18.379))
         
        
         
         userList.append(user1)
         userList.append(user2)
         userList.append(user3)
         userList.append(user4)
         userList.append(user5)
        
        
        return userList
        
    }

    
    
    
}