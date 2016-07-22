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
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(3, 3)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
        
    }
}

class CustomButtonTeal: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.notifiGray().CGColor
        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.notifiTeal()
        self.tintColor = UIColor.blackColor()
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(3, 3)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }
}

class NextButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 1.5
        self.backgroundColor = UIColor.notifiGray()
        self.tintColor = UIColor.whiteColor()
        self.layer.cornerRadius = 10.0
    }
}