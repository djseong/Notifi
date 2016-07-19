//
//  ColorExtension.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func notifiGray() -> UIColor {
        return UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
    }
    class func notifiWhite() -> UIColor {
        return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    class func noticeYellow() -> UIColor{
        return UIColor(red: 253/255, green: 245/255, blue: 144/255, alpha: 1)
    }
    class func noticeGreen() -> UIColor{
        return UIColor(red: 144/255, green: 245/255, blue: 175/255, alpha: 1)
    }
    class func noticeRed() ->UIColor{
        return UIColor(red: 248/255, green: 168/255, blue: 166/255, alpha: 1)
    }
    class func noticeGrey() ->UIColor{
        return UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
    }
    class func noticeButtonGrey() ->UIColor{
        return UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
    }
}
