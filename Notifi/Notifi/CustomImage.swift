//
//  CustomImage.swift
//  Notifi
//
//  Created by Daniel Seong on 7/19/16.
//  Copyright © 2016 Daniel Seong. All rights reserved.
//

import UIKit

extension UIView {
    
    func round()
    {
        let square = CGSize(width: min(self.bounds.width, self.bounds.height), height: min(self.bounds.width, self.bounds.height))
        let center = CGPointMake(square.width / 2, square.height / 2)
        
        let circlePath = UIBezierPath(arcCenter: center, radius: CGFloat(square.width/2), startAngle: CGFloat(0), endAngle: CGFloat(M_PI * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        shapeLayer.lineWidth = 1.0
        
        self.layer.mask = shapeLayer

    }
    
}


