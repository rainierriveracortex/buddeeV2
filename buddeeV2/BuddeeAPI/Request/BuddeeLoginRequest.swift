//
//  BuddeeRequest.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation
import Alamofire

struct Login {
  var username: String
  var password: String
  var appVersion: String = "1.3.3 21"
  var phoneId: String = "A3530F0C-404D-457D-B41B-935440394BE1"
  var platform = "iOS"
  var model: String = "iPhone10,6"
  var pushNotificationId: String = "7FED5B74968CD93D9E59B2E510290F44CF702E3633475B466FD87A11D3F8EDE3"
}

final class LoginRequest: ManagedRequest {
  
  private struct ParameterKeys {
    static let username = "username"
    static let password = "password"
    static let platform = "platform"
    static let model = "model"
    static let appVersion = "app_version"
    static let pushNotificationId = "push_notification_id"
    static let phoneId = "phone_id"
  }
  
  private var login: Login
  
  init(login: Login, networkManager: NetworkManager) {
    self.login = login
    super.init(withNetworkManager: networkManager)
  }
  
  override func requestURL() -> URLConvertible {
      return "https://app.buddee.ph/tio/app/login"
  }
  
  override func requestMethod() -> HTTPMethod {
    return .post
  }
  
  override func encoding() -> ParameterEncoding {
    return JSONEncoding.default
  }
  
  override func parameters() -> [String : Any]? {
    return [ParameterKeys.username: login.username ?? "",
            ParameterKeys.password: login.password ?? "",
            ParameterKeys.platform: login.platform,
            ParameterKeys.phoneId: login.phoneId ?? "",
            ParameterKeys.model: login.model ?? "",
            ParameterKeys.pushNotificationId: login.pushNotificationId ?? "",
            ParameterKeys.appVersion: login.appVersion ?? ""]
  }

}
