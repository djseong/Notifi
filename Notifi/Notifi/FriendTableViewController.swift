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

class FriendTableViewController: UITableViewController {
    @IBOutlet var tableview: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    
    var data:[String] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.addSubview(loader)
        
        // navigation customization
        navigationItem.setHidesBackButton(true, animated: true)
        
        //Tableview customization
        tableview.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "cellidentifier")
        tableview.allowsMultipleSelection = true
        
        // Get List Of Friends
        getAllFriends("") {
            print(self.data.count)
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
        let friendRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: ["fields" : "id, name, picture", "after" : after], HTTPMethod: "GET")
        friendRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if let next = result.valueForKey("paging")?.valueForKey("cursors")?.valueForKey("after") {
                let friends = result["data"] as! [AnyObject]
                for friend in friends {
                    if let name = friend["name"] as? String {
                        self.data.append(name)
                    }
                }
                //print(self.data)
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
        return data.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellidentifier") as! FriendTableViewCell
        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
