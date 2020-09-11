//
//  UIView+Extension.swift
//  WisdomleafUnsplash
//
//  Created by Akhand on 11/09/20.
//  Copyright © 2020 Akhand. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func makeOutwardNeomorphic(reversed: Bool = false, offsetValue: CGFloat = 8.0, cornerRadius: CGFloat = 35.0, shadowRadius: CGFloat = 15.0, alphaLight: CGFloat = 0.2, alphaDark: CGFloat = 0.8) {
        
        let offset = reversed ? offsetValue : -offsetValue
        
        var lightLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            layer.shadowOffset = CGSize(width: offset, height: offset)
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.white.withAlphaComponent(alphaLight).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            layer.cornerRadius = bounds.height / 2.0
            return layer
        }
        
        var darkLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            layer.shadowOffset = CGSize(width: -offset, height: -offset)
            layer.shadowRadius = shadowRadius
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.black.withAlphaComponent(alphaDark).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            layer.cornerRadius = bounds.height / 2.0
            return layer
        }
        
        layer.insertSublayer(lightLayer, at: 0)
        layer.insertSublayer(darkLayer, at: 0)
        
    }
    
    func makeInwardNeomorphic() {
        
        var lightLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            
            let shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: -3, dy: -3), cornerRadius: 35.0)
            let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: 35.0).reversing()
            
            shadowPath.append(cutout)
            layer.shadowPath = shadowPath.cgPath
            
            layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            layer.shadowRadius = 3
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.white.withAlphaComponent(0.8).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            
            return layer
        }
        
        var darkLayer: CALayer {
            let layer = CALayer()
            layer.frame = bounds
            
            let shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 3, dy: 3), cornerRadius: 35.0)
            let cutout = UIBezierPath(roundedRect: bounds, cornerRadius: 35.0).reversing()
            
            shadowPath.append(cutout)
            layer.shadowPath = shadowPath.cgPath
            
            layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
            layer.shadowRadius = 3
            layer.shadowOpacity = 1.0
            layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
            layer.backgroundColor = backgroundColor?.cgColor
            
            return layer
        }
        
        layer.insertSublayer(lightLayer, at: 0)
        layer.insertSublayer(darkLayer, at: 0)
    }
    
}
