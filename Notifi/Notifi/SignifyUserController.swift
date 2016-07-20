//
//  SignifyUserController.swift
//  Notifi
//
//  Created by David Xu on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
class SignifyUserController{
    static var sharedInstance = SignifyUserController()
    private init(){
        
    }
    var currentUser = SignifyUser(lastName: "Xu", firstName: "Siqing")
    
}