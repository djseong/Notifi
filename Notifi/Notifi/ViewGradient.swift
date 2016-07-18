//
//  ViewGradient.swift
//  Notifi
//
//  Created by Daniel Seong on 7/18/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

extension UIView {
    
    func addGradient(from top: UIColor, to bottom: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = layer.frame
        gradient.colors = [top.CGColor, bottom.CGColor]
        layer.insertSublayer(gradient, atIndex: 0)
    }
    
}