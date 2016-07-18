//
//  ViewGradient.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

extension UIView {
    
    func addGradient(top: UIColor, bottom: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [top.CGColor, bottom.CGColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: frame.size.height)
        layer.insertSublayer(gradient, atIndex: 0)
    }
    
}