//
//  UIButton+extension.swift
//  buddeeV2
//
//  Created by jlrivera on 04/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

@IBDesignable
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

extension UIView {
   func roundTopCorners(radius: CGFloat = 10) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}


