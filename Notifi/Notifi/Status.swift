//
//  status.swift
//  Notifi
//
//  Created by David Xu on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
enum State: String{
    case Safe =  "I am Safe"
    case Attention = "Keep an eye on me"
    case Help = "I need help"
}
class Status{
    var state:State
    var time:String
    var user: String
    init(state: State,time: String, user:String){
        self.state = state
        self.time = time
        self.user = user
    }
    
}