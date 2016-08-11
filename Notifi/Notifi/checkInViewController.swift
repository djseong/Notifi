//
//  checkInViewController.swift
//  notifiSam
//
//  Created by Sam on 7/18/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import MessageUI



// to get the index of the selected row




class checkInViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    
    
    
    
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var friendInfo: UIView!
    
    @IBOutlet weak var StatusTableView: UITableView!
    
    
    // These are all outlets for friendInfo View
    
    
    @IBOutlet weak var bigProfileImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    

    var rowindex : Int = 0
    var friendList :[SignifyUser] = []
    var refreshTimer: NSTimer = NSTimer()
    let locationManager = CLLocationManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        friendList = SignifyUserController.sharedInstance.currentUser.friends
        
        //delegate all the important elements in this view
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        StatusTableView.delegate = self
        StatusTableView.dataSource = self

        
        navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        navigationController!.navigationBar.barStyle = UIBarStyle.Black
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        tableView.registerNib(UINib(nibName: "customCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 65
        
        StatusTableView.registerNib(UINib(nibName: "StatusTableViewCell", bundle: nil), forCellReuseIdentifier: "statusCell")
        StatusTableView.rowHeight = 36
    
        // this is to remove the empty space on the top of the table view. ns if it breaks anything lol
        self.automaticallyAdjustsScrollViewInsets = false
        print(friendList.count)
        locationManager.requestWhenInUseAuthorization()
        
        
        // getting the compass to show
        mapView.showsCompass = true
        mapView.rotateEnabled = true
        
        // center the initial mapView to your location
        
        /*
        let userLocation = mapView.userLocation.coordinate
        let span = MKCoordinateSpanMake(0.03, 0.03)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        mapView.setRegion(region, animated: true)
 */
            
        
        
        // do we need an add button?
        navigationItem.title = "Signifi"
        let add_button : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: nil)
        navigationItem.rightBarButtonItem = add_button
        navigationItem.rightBarButtonItem?.enabled = false
        navigationItem.rightBarButtonItem?.tintColor = UIColor.clearColor()
        
  
        // this is a fake back button. It just unhides the tableview and hides the info view.
        let back_button : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_back_transparent"), style:. Done, target: self, action: #selector(backAction(_:)))
        navigationItem.leftBarButtonItem = back_button
        navigationItem.leftBarButtonItem?.enabled = false
        navigationItem.leftBarButtonItem?.tintColor = UIColor.clearColor()
        
        
        // hide the friendInfoView -- this is retarded 
        friendInfo.hidden = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imagePressed))
        bigProfileImage.addGestureRecognizer(tap)
        bigProfileImage.userInteractionEnabled = true
       
        
    }
    override func viewDidDisappear(animated: Bool) {
        self.refreshTimer.invalidate()
    }
    override func viewWillAppear(animated: Bool) {
        self.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(self.populateLocation), userInfo: nil, repeats: true)
        
        tableView.reloadData()
    }
    
    func imagePressed() -> Void {
        
        let friendProfileViewController = FriendProfileViewController(nibName: "FriendProfileViewController", bundle: nil)
        friendProfileViewController.tempImageString = friendList[rowindex].profilePhotoString
        friendProfileViewController.tempName = friendList[rowindex].title
        friendProfileViewController.tempAddress1 = friendList[rowindex].homeAddress
        friendProfileViewController.tempPhone = friendList[rowindex].cellPhone
        friendProfileViewController.tempEmergency = friendList[rowindex].emerCellPhone
        friendProfileViewController.state = friendList[rowindex].currstatus
        self.navigationController?.pushViewController(friendProfileViewController, animated: true)
        
        
    }
    
    
    
   //populate the location of every friend of the user with a coordinate
    func populateLocation(){
        var friendsWithLocation = [SignifyUser]()
        let apiService = APIService()
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/friendship/getlocation"),method:"GET",parameters:nil)
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                for (_,friend) in json{
                    //game = [string, json]
                    var latitude_value: Double = 1.2
                    var longitude_value: Double = 1.2
                    var friend_state: State = .Safe
                    if friend["state"].stringValue != ""{
                        if friend["state"].stringValue == "safe"{ friend_state = .Safe}
                        else if friend["state"].stringValue == "attention"{friend_state = .Attention}
                        else if friend["state"].stringValue == "help"{friend_state = .Help}
                    }
                    for user in self.friendList{
                        if friend["facebook_id"].stringValue == user.fbId{
                            user.currstatus = friend_state
                            break
                        }
                    }
                    if friend["latitude"].stringValue == "" || friend["longitude"].stringValue == "" {
                        for user in self.friendList{
                            if friend["facebook_id"].stringValue == user.fbId{
                                user.coordinate.latitude = 800
                                user.coordinate.longitude = 800
                            }
                        }
                        continue
                    }
                    
                    if friend["latitude"].stringValue != ""{latitude_value = Double(friend["latitude"].stringValue)!}
                    if friend["longitude"].stringValue != ""{longitude_value = Double(friend["longitude"].stringValue)!}
                    let friend_coordinate = CLLocationCoordinate2D(latitude: latitude_value, longitude: longitude_value)
                    for user in self.friendList{
                        if friend["facebook_id"].stringValue == user.fbId{
                            user.coordinate = friend_coordinate
                            friendsWithLocation.append(user)
                            break
                        }
                    }
                    print(latitude_value)
                    print(longitude_value)
                    
                }
                let annotationToRemove = self.mapView.annotations.filter{ $0 !== self.mapView.userLocation }
                self.mapView.removeAnnotations(annotationToRemove)
                self.mapView.addAnnotations(friendsWithLocation)
                self.tableView.reloadData()
                self.StatusTableView.reloadData()
                print(json.count)
            }
            else {
                print(responseCode)
                print(json)
            }
        })
        
        //status update
        if friendList.count - 1 >= rowindex {
        self.getAllStatus(friendList[self.rowindex].fbId!, onCompletion: {statusHistory in
            self.friendList[self.rowindex].statusHistory = statusHistory
            self.StatusTableView.reloadData()
        })
            if friendList[rowindex].currstatus == .Help {
                bigProfileImage.layer.borderColor = UIColor.noticeRed().CGColor
            }
            else if friendList[rowindex].currstatus == .Attention {
                bigProfileImage.layer.borderColor = UIColor.noticeYellow().CGColor
            }
            else {
                bigProfileImage.layer.borderColor = UIColor.noticeGreen().CGColor
            }
        }
        
    }

    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if (tableView == self.tableView)   {
            return friendList.count
        }   else    {
            //statusTableViwe
            if friendList.count == 0 {
                return 0
            }   else    {
                return self.friendList[self.rowindex].statusHistory.count
           }
            
        }
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (tableView == self.tableView)  {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath)
                as! customCellTableViewCell
            
            cell.nameLabel.text = friendList[indexPath.row].title
            
            if friendList[indexPath.row].profilePhotoString != nil {
                let url = friendList[indexPath.row].profilePhotoString
                let picurl = NSURL(string: url!)
                cell.imageview.load(picurl!)
            }
            else {
                cell.imageview.image = nil
            }
            
            
            // get actual colors from the palette
            switch friendList[indexPath.row].currstatus {
                
            case .Help:
                cell.imageview.layer.borderColor = UIColor.noticeRed().CGColor
            case .Attention:
                cell.imageview.layer.borderColor = UIColor.noticeYellow().CGColor
            default:
                cell.imageview.layer.borderColor = UIColor.noticeGreen().CGColor
                
                
            }
            
            
            // tapAction closure sent to IBAction
            cell.tapAction = { (cell) in
                
                let message = self.friendList[indexPath.row].title! + " will be notified that you requested an update."
                
                let alert = UIAlertController(title: "Request Sent!", message: message,
                                              preferredStyle: UIAlertControllerStyle.Alert)
                
                let alertAction = UIAlertAction(title: "Okay", style: .Cancel, handler: { (action) in
                    
                APIServiceController.sharedInstance.sendRequest(self.friendList[indexPath.row].fbId!)
                })
                
                alert.addAction(alertAction)
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
            
            
            return cell
        }   else    {
            //statusTableView
            //change the color of the image view based on the status of the user
            let cell = tableView.dequeueReusableCellWithIdentifier("statusCell", forIndexPath: indexPath)
                as! StatusTableViewCell
            
                cell.statusTimeLabel.text = friendList[rowindex].statusHistory[(friendList[rowindex].statusHistory.count - 1) - indexPath.row].time
                
                
                if self.friendList[self.rowindex].statusHistory[(friendList[rowindex].statusHistory.count - 1) - indexPath.row].state == .Safe  {
                    cell.statusTypeImage.backgroundColor = UIColor.noticeGreen()
                }
                else if self.friendList[self.rowindex].statusHistory[(friendList[rowindex].statusHistory.count - 1) - indexPath.row].state == .Attention {
                    cell.statusTypeImage.backgroundColor = UIColor.noticeYellow()
                }
                else {
                    cell.statusTypeImage.backgroundColor = UIColor.noticeRed()
                }

            return cell
        }
        
        
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.tableView {
            //if the user does not have a location, then don't enlarge
            if friendList[indexPath.row].coordinate.latitude < 400 || friendList[indexPath.row].coordinate.longitude < 400 {
                let location = friendList[indexPath.row].coordinate
                let span = MKCoordinateSpanMake(0.01, 0.01)
                let region = MKCoordinateRegion(center: location, span: span)
                mapView.setRegion(region, animated: true)
            }
        
        
        // there's prob a better solution then this, but never mind!
        for annotation in self.mapView.annotations {
            
            if annotation.title! == friendList[indexPath.row].title {
                mapView.selectAnnotation(annotation, animated: true)
            }
            
            
        }
        
        rowindex = indexPath.row
        StatusTableView.reloadData()
        tableView.hidden = true
        navigationItem.leftBarButtonItem?.enabled = true
        navigationItem.leftBarButtonItem?.tintColor = UIColor.noticeGrey()
        
        
        navigationItem.title = friendList[indexPath.row].title!
        
        // friendInfo stuff
        nameLabel.text = friendList[indexPath.row].title!
        rowindex = indexPath.row
            self.getAllStatus(friendList[rowindex].fbId!, onCompletion: {statusHistory in
            self.friendList[self.rowindex].statusHistory = statusHistory
            })
        bigProfileImage.layer.borderWidth = 2.0;
        bigProfileImage.frame.size.width = 100
        
        if friendList[indexPath.row].profilePhotoString != nil {
            let url = friendList[indexPath.row].profilePhotoString
            let picurl = NSURL(string: url!)
            bigProfileImage.load(picurl!)
            
        }
        else {
            bigProfileImage.image = nil
        }
        
        if friendList[indexPath.row].currstatus == .Help {
            bigProfileImage.layer.borderColor = UIColor.noticeRed().CGColor
        }
        else if friendList[indexPath.row].currstatus == .Attention {
            bigProfileImage.layer.borderColor = UIColor.noticeYellow().CGColor
        }
        else {
            bigProfileImage.layer.borderColor = UIColor.noticeGreen().CGColor
        }

        self.bigProfileImage.layer.cornerRadius = self.bigProfileImage.frame.size.width / 2
        self.bigProfileImage.clipsToBounds = true
        
        friendInfo.hidden = false
        }
        
        else {
            
        }
        
    }


    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
 
        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("MyPin") as? SVPulsingAnnotationView
        
        
        if (annotationView == nil) {
             annotationView = SVPulsingAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            annotationView!.canShowCallout = true
            
            
            
            var frame = annotationView!.frame
            frame.size.height = 25
            frame.size.width = 25
            annotationView!.frame = frame
            
            
            
            
        }
        
        let annotationUser = annotation as! SignifyUser
        
        
        if annotationUser.currstatus == .Help {
            annotationView?.annotationColor = UIColor.noticeRed()
        }
        else if annotationUser.currstatus == .Attention {
            annotationView?.annotationColor = UIColor.noticeYellow()
        }
        else {
            annotationView?.annotationColor = UIColor.noticeGreen()
        }

        
        annotationView!.annotation = annotation
        return annotationView!
        
    }
    
    
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    
        
    func addAction(sender:UIBarButtonItem) {
            
        print("This do something?")
        
        }
    
    func backAction(sender: UIBarButtonItem) {
        self.tableView.hidden = false
        self.friendInfo.hidden = true
        navigationItem.title = "Signifi"
        // hides the back button to imitate an actual back button
        navigationItem.leftBarButtonItem?.enabled = false
        navigationItem.leftBarButtonItem?.tintColor = UIColor.clearColor()
        
        
    }
    
    
    
    
    // These are all actions for the friendInfo View
    
    //handle the call button and message button pressed
    @IBAction func callButtonPressed(sender: UIButton) {
        print("call button pressed")
        if friendList[rowindex].cellPhone != ""{
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(friendList[rowindex].cellPhone)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
        }else{
            let alert = UIAlertController(title: "Sorry", message: "your friend has not add his or her cellphone number yet", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func textButtonPressed(sender: UIButton) {
        if friendList[rowindex].cellPhone != ""{
        if (MFMessageComposeViewController.canSendText()) {
            
          
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [friendList[rowindex].cellPhone]
            controller.messageComposeDelegate = self
            self.presentViewController(controller, animated: true, completion: nil)
        
        }
        }else{
            let alert = UIAlertController(title: "Sorry", message: "your friend has not add his or her cellphone number yet", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


    
    @IBAction func bigRequestButtonPressed(sender: UIButton) {
        let message = friendList[rowindex].title! + " will be notified that you requested an update."
        let alert = UIAlertController(title: "Request Sent!", message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .Cancel, handler: { (action) in
            
        APIServiceController.sharedInstance.sendRequest(self.friendList[self.rowindex].fbId!)
            
        })
        
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    //get the history of status of the user's friend and render the time of status into "xxx ago"
    func getAllStatus(facebook_id: String, onCompletion:([Status])->Void){
        let apiService = APIService()
        var statusHistory = [Status]()
        let request = apiService.createMutableAnonRequest(NSURL(string: "https://polar-hollows-23592.herokuapp.com/friendship/gethist"),method:"POST",parameters:["facebook_id":facebook_id])
        apiService.executeRequest(request, requestCompletionFunction: {responseCode, json in
            if responseCode/100 == 2{
                for (_,status) in json{
                    let datestring = status["time"].stringValue
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
                    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzz'Z'"
                    let availableDate = dateFormatter.dateFromString(datestring)
                    
                    var friend_state:State = .Safe
                    if status["state"].stringValue != ""{
                        if status["state"].stringValue == "safe"{ friend_state = .Safe}
                        else if status["state"].stringValue == "attention"{friend_state = .Attention}
                        else if status["state"].stringValue == "help"{friend_state = .Help}
                    }
                    let currentDateTime = NSDate()
                    let seconds = currentDateTime.timeIntervalSinceDate(availableDate!)
                    
                    if seconds > 259200{
                        continue
                    }
                    var dateString = ""
                    if seconds <= 259200 && seconds >= 86400{
                        let t:Int = Int(seconds/86400)
                        if t == 1{
                            dateString = "\(t) day ago"
                        }else{
                            dateString = "\(t) days ago"
                        }
                    }else if seconds >= 3600 && seconds < 86400{
                        let t:Int = Int(seconds/3600)
                        if t == 1{
                            dateString = "\(t) hour ago"
                        }else{
                            dateString = "\(t) hours ago"
                        }
                    }else if seconds >= 60 && seconds < 3600 {
                        let t:Int = Int(seconds/60)
                        if t == 1{
                            dateString = "\(t) minute ago"
                        }else{
                            dateString = "\(t) minutes ago"
                        }
                    }else if seconds > 0 && seconds < 60{
                        let t = Int(seconds)
                        dateString = "\(t) seconds ago"
                    }
                    let new_status = Status(state: friend_state, time: dateString, user: facebook_id)
                    statusHistory.append(new_status)
                }
                onCompletion(statusHistory)
                self.tableView.reloadData()
                self.StatusTableView.reloadData()
                
            }
            else {
                print(responseCode)
                print(json)
                onCompletion(statusHistory)
                self.tableView.reloadData()
                self.StatusTableView.reloadData()
            }
        })
        
    }


   
}
