//
//  NotifyFriendListViewController.swift
//  Notifi
//
//  Created by David Xu on 8/9/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class NotifyFriendListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notifySwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    let defaults = NSUserDefaults.standardUserDefaults()
    var useList:Bool = SignifyUserController.sharedInstance.currentUser.useNotifyFriendList
    var selectedRows:[Int] = []
    var selectedFriend: [String] = SignifyUserController.sharedInstance.currentUser.notifyFriendList
    let friendList = SignifyUserController.sharedInstance.currentUser.friends
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 112
        tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellidentifier")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        if friendList.count > 0{
        for index in 0...friendList.count-1{
            for selected in selectedFriend{
                if friendList[index].fbId == selected{
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: .Middle)
                    selectedRows.append(index)
                }
            }
        }
        }
        
        //set up switch
        notifySwitch.onTintColor = UIColor.notifiTeal()
        notifySwitch.backgroundColor = UIColor.noticeGrey()
        notifySwitch.transform = CGAffineTransformMakeScale(1.0, 1.0)
        notifySwitch.layer.cornerRadius = 16
        notifySwitch.on = useList
        if useList{
        }else{
            tableView.hidden = true
        }
        let saveButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: #selector(self.savePressed(_:)))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(self.cancelPressed(_:)))
        self.navigationItem.setRightBarButtonItem(saveButton, animated: true)
        self.navigationItem.setLeftBarButtonItem(cancelButton, animated: true)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCellWithIdentifier("cellidentifier") as! FriendTableViewCell
        newCell.nameLabel.text = friendList[indexPath.row].firstName
        let url = friendList[indexPath.row].profilePhotoString
        let picurl = NSURL(string: url!)
        //newCell.ImageView.round()
        newCell.ImageView.load(picurl!)
        return newCell

        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.imageView?.round()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(tableView.indexPathForSelectedRow?.row)
        selectedFriend.append(friendList[indexPath.row].fbId!)
        selectedRows.append(indexPath.row)


    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        for (index,item) in selectedRows.enumerate()    {
            if (item == indexPath.row)   {
                
                selectedRows.removeAtIndex(index)
                selectedFriend.removeAtIndex(index)
                break
            }
        }
    }
    
    @IBAction func switchChanged(sender: UISwitch) {
        if sender.on{
            useList = true
            tableView.hidden = false
        }else{
            useList = false
            tableView.hidden = true
        }
    }
    func savePressed(sender: UIBarButtonItem){
        //set current
        SignifyUserController.sharedInstance.currentUser.useNotifyFriendList = useList
        SignifyUserController.sharedInstance.currentUser.notifyFriendList = selectedFriend
        //TODO set defaults
        defaults.setObject(selectedFriend, forKey: "SignifyFriendsList")
        defaults.setObject(useList, forKey: "IfUseList")
        defaults.synchronize()
        //go back
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func cancelPressed(sender: UIBarButtonItem){
        self.navigationController?.popViewControllerAnimated(true)
    }
    

   

}
