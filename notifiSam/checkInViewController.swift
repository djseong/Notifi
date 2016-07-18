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

class checkInViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var mapView: MKMapView!

    @IBOutlet weak var tableView: UITableView!
    
    var friendList : [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        tableView.registerNib(UINib(nibName: "customCellTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 80
        
        // this is to remove the empty space on the top of the table view. ns if it breaks anything lol
        self.automaticallyAdjustsScrollViewInsets = false
        
        friendList = UserController.sharedInstance.getJournals()
        
        mapView.addAnnotations(friendList)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendList.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
      
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath)
            as! customCellTableViewCell
        
        
        
        cell.nameLabel.text = friendList[indexPath.row].title
        
        
        // get actual colors from the palette
        switch friendList[indexPath.row].status {
            
        case .Danger:
            cell.imageview.layer.borderColor = UIColor.redColor().CGColor
        case .Weary:
            cell.imageview.layer.borderColor = UIColor.yellowColor().CGColor
        default:
            cell.imageview.layer.borderColor = UIColor.greenColor().CGColor
  
            
        }

        
        return cell
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation.isKindOfClass(MKUserLocation)) {
            return nil
        }
        
        let identifier = "MyPin"
        
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier("MyPin") as? MKPinAnnotationView
        
        
        
        if (annotationView == nil) {
            
            
            let leftLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
            leftLabel.textColor = UIColor.blackColor()
            
            
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            
            
            
            annotationView!.leftCalloutAccessoryView = leftLabel
            annotationView!.canShowCallout = true
            
            
            
            var frame = annotationView!.frame
            frame.size.height = 25
            frame.size.width = 25
            annotationView!.frame = frame
            
            
            
            
        }
        
        
        
        annotationView!.annotation = annotation
        return annotationView!
        
    }
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
