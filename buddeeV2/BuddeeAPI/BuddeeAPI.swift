//
//  BuddeeAPI.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

protocol BuddeeAPI {
  func login(login: Login, completion: @escaping (APIResponse<LoginResponse>) -> Void)
  func register(register: RegisterUser, completion: @escaping (APIResponse<RegistrationResponse>) -> Void)
  func getProfile(user: User, completion: @escaping (APIResponse<UserProfile>) -> Void)
  func getAllDevices(user: User, compeletion: @escaping (APIResponse<AllDevices>) -> Void)
  func turnPlug(plugState: PlugState, user: User, device: Device, completion: @escaping (APIResponse<PlugResponse>) -> Void)
}
