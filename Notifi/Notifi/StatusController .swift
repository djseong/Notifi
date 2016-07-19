//
//  statusController .swift
//  Notifi
//
//  Created by David Xu on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import Foundation
class StatusController{
    static var sharedInstance = StatusController()
    
    var currentStatus: Status
    
    private init(){
        currentStatus = Status(state: .Safe, time: "my time", user: "David Xu")
    }
    
    func changeCurrentState(state: State){
        if state == .Safe{
            currentStatus = Status(state: .Safe, time: "new time", user: "David Xu")
        }
        else if state == .Attention{
            currentStatus = Status(state: .Attention, time: "new time", user: "David Xu")
        }
        else if state == .Help{
            currentStatus = Status(state: .Help, time: "new time", user: "David Xu")
        }
    }
    
}