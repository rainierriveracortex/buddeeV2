//
//  BuddeeNetworkService.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

// Use this service for getting API specifically for itunes
struct BuddeeNetworkService {
    private let networkManager : NetworkManager
    
    init(networkManager: NetworkManager = .init()) {
        self.networkManager = networkManager
    }
}

extension BuddeeNetworkService: BuddeeAPI {
  func login(login: Login, completion: @escaping (APIResponse<LoginResponse>) -> Void) {
    LoginRequest(login: login, networkManager: networkManager).request(completion: completion)
  }
  
  func register(register: RegisterUser, completion: @escaping (APIResponse<RegistrationResponse>) -> Void) {
    RegistrationRequest(registerUser: register, networkManager: networkManager).request(completion: completion)
  }
}
