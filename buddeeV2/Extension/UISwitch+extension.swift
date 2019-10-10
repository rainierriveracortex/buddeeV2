//
//  UISwitch+extenstion.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

extension UISwitch {
  func setScale(width: CGFloat, height: CGFloat) {
    let standardHeight: CGFloat = 31
    let standardWidth: CGFloat = 51
    
    let heightRatio = height / standardHeight
    let widthRatio = width / standardWidth
    
    transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
  }
}
