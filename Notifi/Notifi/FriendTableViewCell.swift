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
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
