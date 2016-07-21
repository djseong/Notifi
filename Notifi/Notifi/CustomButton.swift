//
//  CustomButton.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class CustomButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.whiteColor()
        self.tintColor = UIColor.blackColor()
        //self.contentEdgeInsets = UIEdgeInsets(top: 20.0, left: 90.0, bottom: 20.0, right: 90.0)
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(3, 3)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
        //let preferredDescriptor = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        //self.titleLabel?.font = UIFont(name: "Symbol", size: preferredDescriptor.pointSize)
    }
}

class NextButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.notifiGray().CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.notifiGray()
        self.tintColor = UIColor.whiteColor()
        self.layer.cornerRadius = 10.0

        //let preferredDescriptor = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        //self.titleLabel?.font = UIFont(name: "Symbol", size: preferredDescriptor.pointSize)
    }
}