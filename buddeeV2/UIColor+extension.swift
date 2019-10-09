//
//  UIColor+extension.swift
//  buddeeV2
//
//  Created by jlrivera on 03/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

extension UIColor {
    static var themeColor: UIColor {
        return UIColor(red: 0/255, green: 171/255, blue: 209/255, alpha: 1)
    }
    
    static var unselectedPageColor: UIColor {
        return UIColor(red: 125/255, green: 211/255, blue: 242/255, alpha: 1)
    }
    
    static var selectedPageColor: UIColor {
        return themeColor
    }
  
  static var buddeeLightGrayColor: UIColor {
    return UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
  }
}

