//
//  RegistrationResponse.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation
import Alamofire

final class RegistrationRequest: ManagedRequest {
  
  private let registerUser: RegisterUser
  
  private struct ParameterKeys {
    static let username = "username"
    static let emaildAddress = "email_address"
    static let password = "password"
    static let fbAuthId = "fb_oauth_id"
    static let accessToken = "access_token"
    static let firstName = "first_name"
    static let lastName = "last_name"
    static let birthDate = "birth_date"
    static let gender = "gender"
    static let pushNotificationId = "push_notification_id"
    static let platform = "platform"
    static let model = "model"
    static let longitude = "longitude"
    static let latitude = "latitude"
    static let mobileNumber = "mobile_number"
    static let phoneId = "phone_id"
  }

  init(registerUser: RegisterUser, networkManager: NetworkManager) {
    self.registerUser = registerUser
    super.init(withNetworkManager: networkManager)
  }
  
  override func requestURL() -> URLConvertible {
    return "https://app.buddee.ph/tio/app/register"
  }
  
  override func requestMethod() -> HTTPMethod {
    return .post
  }
  
  override func encoding() -> ParameterEncoding {
    return JSONEncoding.default
  }
  
  override func parameters() -> [String : Any]? {
    return [ParameterKeys.username: registerUser.email ?? "",
            ParameterKeys.emaildAddress: registerUser.email ?? "",
            ParameterKeys.password: registerUser.password ?? "",
            ParameterKeys.fbAuthId: "",
            ParameterKeys.accessToken: "",
            ParameterKeys.firstName: registerUser.firstName ?? "",
            ParameterKeys.lastName: registerUser.lastName ?? "",
            ParameterKeys.birthDate: "",
            ParameterKeys.gender: "",
            ParameterKeys.pushNotificationId: registerUser.pushNotificationId,
            ParameterKeys.platform: registerUser.platform,
            ParameterKeys.model: registerUser.model,
            ParameterKeys.longitude: "",
            ParameterKeys.latitude: "",
            ParameterKeys.mobileNumber: registerUser.mobile ?? "",
            ParameterKeys.phoneId: registerUser.phoneId]
  }
}
