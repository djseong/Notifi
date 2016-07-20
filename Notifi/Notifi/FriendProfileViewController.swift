//
//  FriendProfileViewController.swift
//  Notifi
//
//  Created by Sam on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class FriendProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
    
        
        
            print(friendList.count)
    
        return friendList[rowindex].statusHistory.count
        
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView
        
        
        
        
                        
            let cell = tableView.dequeueReusableCellWithIdentifier("statusCell", forIndexPath: indexPath)
                as! StatusTableViewCell
        
            
            
            cell.statusTimeLabel.text = friendList[rowindex].statusHistory[indexPath.row].time
        
            
            
            
            // get actual colors from the palette
            switch //CheckInViewController.friendList[CheckInViewController.rowindex].statusHistory[indexPath.row].state
                friendList[rowindex].statusHistory[indexPath.row].state{
                
            case .Safe:
                cell.statusTypeImage.backgroundColor = UIColor.greenColor()
            case .Attention:
                cell.statusTypeImage.backgroundColor = UIColor.greenColor()
            default:
                cell.statusTypeImage.backgroundColor = UIColor.greenColor()
                
                
            }
        
            
            return cell
        
    }

    


}
