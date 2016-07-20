//
//  SettingViewController.swift
//  Notifi
//
//  Created by David Xu on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBAction func switchTurned(sender: UISwitch) {
        if sender.on{
            let alert = UIAlertController(title: "Your GPS is on", message: "By turning on the GPS, your friends will be able to see you on the map", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay, I see", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Your GPS is off", message: "By turning off the GPS, your friends will not be able to see you on the map", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Okay, I see", style: .Cancel, handler: nil)
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBOutlet weak var gpsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var switchGPS: UISwitch!
    var settingArray = ["My profile","Emergency Contact"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "icon_settings_full.png"))
        self.view.backgroundColor = UIColor.nightlyBackgroundGrey()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.nightlyBackgroundGrey()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingcell")
                
        switchGPS.onTintColor = UIColor.notifiTeal()
        switchGPS.backgroundColor = UIColor.noticeGrey()
        switchGPS.transform = CGAffineTransformMakeScale(2.0, 2.0)
        switchGPS.layer.cornerRadius = 16
        
        gpsLabel.font = UIFont(name: "Montserrat-UltraLight", size: 20)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let newCell = tableView.dequeueReusableCellWithIdentifier("settingcell",forIndexPath: indexPath)
        newCell.backgroundColor = UIColor.nightlyBackgroundGrey()
        let myfont = UIFont(name: "Montserrat-UltraLight", size: 30)
        newCell.textLabel?.text = settingArray[indexPath.row]
        newCell.textLabel?.textColor = UIColor.noticeGrey()
        newCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        newCell.textLabel?.font = myfont
        
        return newCell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0{
            navigationController?.pushViewController(MyProfileViewController(), animated: true)
        }
        else if indexPath.row == 1{
            navigationController?.pushViewController(MyProfileViewController(), animated: true)
        }
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
