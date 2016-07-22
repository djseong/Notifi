//
//  NoticeViewController.swift
//  
//
//  Created by David Xu on 7/18/16.
//
//

import UIKit

class NoticeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var call911Button: UIButton!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    var navBar = UINavigationBar()
    var friendList = [SignifyUser]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WebDatabase.sharedInstance.retriveContact(onCOmpletion: {users in
            self.friendList = users
            self.collectionView.reloadData()
            self.messageLabel.text = "was sent to \(self.friendList.count) friends"
            //self.tableView.reloadData()
        })
        messageLabel.text = "was sent to \(friendList.count) friends"
        
        navBar.barTintColor = UIColor.blackColor()
        navBar.barStyle = .Black
        navBar.tintColor = UIColor.whiteColor()
        self.navigationItem.title = "Thank you for checking in"
        navBar.frame = CGRectMake(0, 0, self.view.frame.width, 60)
        self.view.addSubview(navBar)
        stateLabel.font = UIFont(name: "Helvetica", size: 30)
        if StatusController.sharedInstance.currentStatus.state == .Safe{
            self.view.backgroundColor = UIColor.noticeGreen()
            stateLabel.text = "I am safe"
            stateLabel.textColor = UIColor.noticeButtonGreen()
            emergencyButton.hidden = true
            call911Button.hidden = true
        }
        else if StatusController.sharedInstance.currentStatus.state == .Attention{
            self.view.backgroundColor = UIColor.noticeYellow()
            stateLabel.text = "Keep an eye on me"
            stateLabel.textColor = UIColor.noticeButtonYellow()
            emergencyButton.hidden = true
            call911Button.hidden = true
        }
        else if StatusController.sharedInstance.currentStatus.state == .Help{
            self.view.backgroundColor = UIColor.noticeRed()
            stateLabel.text = "I need help"
            stateLabel.textColor = UIColor.noticeButtonRed()
        }
        
        

        
        collectionView.registerNib(UINib(nibName:"PhotoProfileCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "CellForPhoto")
        collectionView.delegate = self
        collectionView.dataSource = self
        
         //let innerView = UIView(frame: CGRect(x: 57, y: 90, width: 300, height: 600))
         innerView.backgroundColor = UIColor.noticeGrey()
         self.view.addSubview(innerView)
         innerView.addSubview(collectionView)
         innerView.addSubview(stateLabel)
         innerView.addSubview(messageLabel)
         innerView.addSubview(okayButton)
         innerView.addSubview(emergencyButton)
         innerView.addSubview(call911Button)
         collectionView.frame = CGRect(x: 5, y: 5, width: 250, height: 250)
         collectionView.backgroundColor = UIColor.noticeGrey()
         okayButton.backgroundColor = UIColor.notifiTeal()
         okayButton.layer.cornerRadius = 5
         okayButton.titleLabel?.tintColor = UIColor.blackColor()
         innerView.layer.cornerRadius = 5
        
         emergencyButton.layer.cornerRadius = 5
         call911Button.layer.cornerRadius = 5
        
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        self.collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendList.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        //let userList = [icon_image,icon_image,icon_image,icon_image]
        let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("CellForPhoto", forIndexPath: indexPath) as! PhotoProfileCollectionViewCell
        let url = friendList[indexPath.row].profilePhotoString
        let picurl = NSURL(string: url!)
        //cell.ImageView.round()
        newCell.contentImage.load(picurl!)
        return newCell
    }
    
    @IBAction func okayPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func call911ButtonPressed(sender: UIButton) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://911") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }

    
    // MARK: - Navigation

    // TODO: set as current user emergency contact
     @IBAction func emergencyButtonPressed(sender: UIButton) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(2035510306)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
     }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
