//
//  PlugRequest.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation
import Alamofire

enum PlugState: String {
  case on, off
  
  static func plugState(string: String) -> PlugState {
    if string.lowercased() == "on".lowercased() {
      return .on
    }
    return .off
  }
  static func plugState(isOn: Bool) -> PlugState {
    if isOn {
      return .on
    } else {
      return .off
    }
  }
}

final class PlugRequest: ManagedRequest {
  
  private let user: User
  private let device: Device
  private let plugState: PlugState
  
  init(user: User, device: Device, plugState: PlugState, networkManager: NetworkManager) {
    self.user = user
    self.device = device
    self.plugState = plugState
    super.init(withNetworkManager: networkManager)
  }
  private struct ParameterKeys  {
    static let userId = "user_id"
    static let serial = "serial"
    static let platform = "platform"
    static let state = "state"
  }
  
  override func requestURL() -> URLConvertible {
    return "https://app.buddee.ph/tio/app/plug"
  }
  
  override func requestMethod() -> HTTPMethod {
    return .post
  }
  
  override func encoding() -> ParameterEncoding {
    return JSONEncoding.default
  }
  
  override func parameters() -> [String : Any]? {
    return [ParameterKeys.userId: user.userId,
            ParameterKeys.platform: "iOS",
            ParameterKeys.state: plugState.rawValue.lowercased(),
            ParameterKeys.serial: device.serial]
  }
  
  
}
