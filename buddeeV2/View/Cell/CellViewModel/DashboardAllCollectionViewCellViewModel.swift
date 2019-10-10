//
//  DashboardAllCollectionViewCellViewModel.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

class DashboardAllCollectionViewCellViewModel {
  let device: Device
  
  init(device: Device) {
    self.device = device
  }
  
  var powerStateString: String {
    return device.powerState.capitalized
  }
  
  var locatioName: String {
    return device.locationName
  }
  
  var isOn: Bool {
    return powerStateString.uppercased() == "on".uppercased()
  }

}
