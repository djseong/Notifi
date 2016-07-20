//
//  PhotoProfileCollectionViewCell.swift
//  Notifi
//
//  Created by David Xu on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

class PhotoProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentImage.layer.cornerRadius = 75 * 0.5
        //contentImage.backgroundColor = UIColor.blueColor()
    }
    

}
