//
//  GetProfileRequest.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation
import Alamofire

final class GetProfileRequest: ManagedRequest {

  private var user: User
  
  private struct ParameterKeys {
    static let userId = "user_id"
    static let phoneId = "phone_id"
  }
  
  init(user: User, networkManager: NetworkManager) {
    self.user = user
    super.init(withNetworkManager: networkManager)
  }
  
  override func requestURL() -> URLConvertible {
    return "https://app.buddee.ph/tio/app/profile"
  }
  
  override func parameters() -> [String : Any]? {
    return [ParameterKeys.userId: user.userId,
            ParameterKeys.phoneId: user.phoneId]
  }
}
