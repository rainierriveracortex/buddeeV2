//
//  LoginResponse.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

class AppHelper {
  static let shared = AppHelper()
  private var user: User?
  
  func saveUser(user: User) {
    self.user = user
  }
  
  func getCurrentUser() -> User? {
    return user
  }
}

class User {
  
  let userId: String
  let phoneId: String
  
  var userProfile: UserProfile? {
    didSet {
      AppHelper.shared.saveUser(user: self)
    }
  }
  
  init(userId: String, phoneId: String) {
    self.userId = userId
    self.phoneId = phoneId
  }
  
  func updateUserProfile(_ userProfile: UserProfile) {
    self.userProfile = userProfile
    
  }
  
}

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let userID: String
    let error: Int
    let message, session: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case error, message, session
    }
}
