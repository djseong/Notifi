//
//  customCellTableViewCell.swift
//  notifiSam
//
//  Created by Sam on 7/18/16.
//  Copyright © 2016 Sam. All rights reserved.
//

import UIKit
import QuartzCore

class customCellTableViewCell: UITableViewCell {


    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        imageview.layer.borderColor = UIColor.greenColor().CGColor
        imageview.layer.borderWidth = 2.0;
        
        self.imageview.layer.cornerRadius = self.imageview.frame.size.width / 2
        self.imageview.clipsToBounds = true
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.backgroundColor = .None
        
    }
    
    
    
    @IBAction func requestButtonPressed(sender: UIButton) {
        print("Request button pressed")
    }
}
