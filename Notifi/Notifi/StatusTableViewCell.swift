//
//  CustomStatusTableViewCell.swift
//  Notifi
//
//  Created by Sam on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusTimeLabel: UILabel!
    
    @IBOutlet weak var statusTypeImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        statusTypeImage.layer.borderWidth = 2.0;
        
        self.statusTypeImage.layer.cornerRadius = self.statusTypeImage.frame.size.width / 2
        self.statusTypeImage.clipsToBounds = true
        self.backgroundColor = UIColor.darkGrayColor()

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        // I don't want it to grayed when selected
        super.setSelected(false, animated: animated)
    }
    
}
