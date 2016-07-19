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
    
    
    var tapAction: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        imageview.layer.borderWidth = 2.0;
        
        self.imageview.layer.cornerRadius = self.imageview.frame.size.width / 2
        self.imageview.clipsToBounds = true
        self.backgroundColor = UIColor.darkGrayColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        // I don't want it to grayed when selected
        super.setSelected(false, animated: animated)

     
        
    }
    
    
    
    
    
    @IBAction func requestButtonPressed(sender: UIButton) {
        print("Request button pressed")
        
        tapAction?(self)
        
        
               
        

        
        


    }
}
