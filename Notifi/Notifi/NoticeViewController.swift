//
//  NoticeViewController.swift
//  
//
//  Created by David Xu on 7/18/16.
//
//

import UIKit

class NoticeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var messageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if StatusController.sharedInstance.currentStatus.state == .Safe{
            self.view.backgroundColor = UIColor.noticeGreen()
            stateLabel.text = "I am safe"
        }
        else if StatusController.sharedInstance.currentStatus.state == .Attention{
            self.view.backgroundColor = UIColor.noticeYellow()
            stateLabel.text = "Keep an eye on me"
        }
        else if StatusController.sharedInstance.currentStatus.state == .Help{
            self.view.backgroundColor = UIColor.noticeRed()
            stateLabel.text = "I need help"
        }

        
        collectionView.registerNib(UINib(nibName:"PhotoProfileCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: "CellForPhoto")
        collectionView.delegate = self
        collectionView.dataSource = self
        
         let innerView = UIView(frame: CGRect(x: 57, y: 90, width: 300, height: 600))
         innerView.backgroundColor = UIColor.noticeGrey()
         self.view.addSubview(innerView)
         innerView.addSubview(collectionView)
         innerView.addSubview(stateLabel)
         innerView.addSubview(messageLabel)
         innerView.addSubview(okayButton)
         collectionView.frame = CGRect(x: 5, y: 5, width: 250, height: 240)
         collectionView.backgroundColor = UIColor.noticeGrey()
         okayButton.backgroundColor = UIColor.noticeButtonGrey()
         okayButton.layer.cornerRadius = 5
         innerView.layer.cornerRadius = 5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let icon_image = UIImage(named: "settings_icon.png")
        //let userList = [icon_image,icon_image,icon_image,icon_image]
        let newCell = collectionView.dequeueReusableCellWithReuseIdentifier("CellForPhoto", forIndexPath: indexPath) as! PhotoProfileCollectionViewCell
        newCell.contentImage.image = icon_image
        return newCell
    }
    
    @IBAction func okayPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
