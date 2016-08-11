//
//  FriendTableViewCell.swift
//  Notifi
//
//  Created by Daniel Seong on 7/20/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.ImageView.clipsToBounds = true
        self.ImageView.layer.cornerRadius = 50
    }
    


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            checkImage.hidden = false
        }
        else {
            checkImage.hidden = true
        }
        
    }
    
}
