//
//  DashboardViewModel.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

protocol DashboardViewModelDelegate: class {
  func dashboardViewModelDelegateReloadCollectionView(_ viewModel: DashboardViewModel)
  func dashboardViewModelDelegateShouldShowLoading(_ viewModel: DashboardViewModel, shouldShow: Bool)
}

class DashboardViewModel {
  
  let user: User
  
  var networkManager: BuddeeAPI
  
  weak var delegate: DashboardViewModelDelegate?
  private var devices = [Device]()
  
  init(networkManager: BuddeeAPI = BuddeeNetworkService()) {
    guard let user = AppHelper.shared.getCurrentUser() else {
      fatalError("Could not find user")
    }
    self.networkManager = networkManager
    self.user = user
  }
  
  var numberofRows: Int {
    return devices.count
  }
  
  var numberofSections: Int {
    return 1
  }
  
  var navigationTitle: String {
    return "Dashboard"
  }
  
  var devicesConnectedText: String {
    let connectedDevices = devices.filter { PlugState.plugState(string: $0.wifiState) == .on }
    return "\(connectedDevices.count) Devices Connected"
  }
  
  var isAllSwitchOn: Bool {
    return (devices.first { (device) -> Bool in
      let plugState = PlugState.plugState(string: device.powerState)
      return plugState == PlugState.on
      } != nil)
  }
  
  func currentDevice(row: Int) -> Device {
    return devices[row]
  }
  
  func getProfile() {
    networkManager.getProfile(user: user) { [weak self] response in
      guard let self = self else { return }
      
      switch response {
      case let .success(UserProfile): break
     //   print(UserProfile)
      case let .error(error): break
   //     print(error)
      }
    }
  }
  
  func getDevices() {
    delegate?.dashboardViewModelDelegateShouldShowLoading(self, shouldShow: true)
    networkManager.getAllDevices(user: user) { [weak self] response in
      guard let self = self else { return }
      self.delegate?.dashboardViewModelDelegateShouldShowLoading(self, shouldShow: false)
      switch response {
      case let .success(allDevices):
        self.devices = allDevices.device
        self.delegate?.dashboardViewModelDelegateReloadCollectionView(self)
      case let .error(error):
        print(error)
      }
    }
  }
  
  func turnPlug(plugState: PlugState, device: Device) {
    networkManager.turnPlug(plugState: plugState, user: user, device: device) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case .success:
        device.powerState = plugState.rawValue
        self.delegate?.dashboardViewModelDelegateReloadCollectionView(self)
      case .error: break
      }
    }
  }
  
  func turnAllPlug(plugState: PlugState) {
    for device in devices {
      networkManager.turnPlug(plugState: plugState, user: user, device: device) { [weak self] response in
        guard let self = self else { return }
        switch response {
        case .success(_):
          device.powerState = plugState.rawValue
          self.delegate?.dashboardViewModelDelegateReloadCollectionView(self)
        case .error: break
        }
      }
    }
  }

}
