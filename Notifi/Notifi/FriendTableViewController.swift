//
//  FriendTableViewController.swift
//  Notifi
//
//  Created by Daniel Seong on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit
import ImageLoader



// putting the data into a class
class DataItem {
    
    var first_name : String
    var last_name : String
    var email : String?
    var id : String
    var pictureString : String
    
    
    init(first_name: String, last_name: String, id: String, pictureString: String) {
        
        self.first_name = first_name
        self.last_name = last_name
        self.id = id
        self.pictureString = pictureString
    }
    
    
    
}



class FriendTableViewController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    var selectedRows:[Int] = []
   // var data:[String] = []
    
    var dataArr: [DataItem] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.addSubview(loader)
        
        
        tableView.rowHeight = 112
        
        // navigation customization
        navigationItem.setHidesBackButton(true, animated: true)
        
        //Tableview customization
        tableview.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellidentifier")
        tableview.allowsMultipleSelection = true
        
        // Get List Of Friends
        getAllFriends("") {
            print(self.dataArr.count)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(self.addFriends))
            self.loader.stopAnimating()
            self.loader.hidden = true
            self.tableview.reloadData()
        }
      
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
    
    override func viewDidAppear(animated: Bool) {
        loader.center = self.view.center
        loader.startAnimating()
    }
    
    func addFriends() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let application = UIApplication.sharedApplication()
        let window = application.keyWindow
        window?.rootViewController = appDelegate.initTabBarController()
    }
    
    

    
    func getAllFriends (after: String, onCompletion: () -> Void) {
        let friendRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields" : "id, first_name, last_name, email, picture.type(large)", "after" : after], HTTPMethod: "GET")
        friendRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if let next = result.valueForKey("paging")?.valueForKey("cursors")?.valueForKey("after") {
                let friends = result["data"] as! [AnyObject]
                for friend in friends {
                    print(friend)
                    let dataItem = DataItem(first_name: friend["first_name"] as! String, last_name: friend["last_name"] as! String, id: friend["id"] as! String, pictureString: friend["picture"]!["data"]!["url"] as! String)
               
                    
                // still crashes since friend don't even have an email field if the person has no email 
                /*    if friend["email"] != nil {
                        dataItem.email = friend["email"]
                    } */

                        self.dataArr.append(dataItem)
                    
                }
             
                //onCompletion()
                self.getAllFriends(next as! String, onCompletion: onCompletion)
            }
            else {
                onCompletion()
            }
            //print(self.data)
            // self.tableview.reloadData()
        })
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.imageView?.round()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellidentifier") as! FriendTableViewCell
        
        cell.nameLabel.text = dataArr[indexPath.row].first_name
        let url = dataArr[indexPath.row].pictureString
        let picurl = NSURL(string: url as! String)
        //cell.ImageView.round()
        cell.ImageView.load(picurl!)


        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var isAlreadyContained = false
        for (index,item) in selectedRows.enumerate()    {
            if (item == indexPath.row)   {
                
                isAlreadyContained = true
                selectedRows.removeAtIndex(index)
                break
            }
        }
        if isAlreadyContained == false  {
            selectedRows.append(indexPath.row)
            
        }
//        tableView.reloadData()
        
    }
    
    
}
