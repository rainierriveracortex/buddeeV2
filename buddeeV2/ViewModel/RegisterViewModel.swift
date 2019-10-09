//
//  RegisterUserViewModel.swift
//  buddeeV2
//
//  Created by jlrivera on 07/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

protocol RegisterViewModelType {
  func createRegisterUser(withFirstName firstName: String, lastName: String, mobileNumber: String)
  func registerUserToAPI()
  func updateRegisterUser(withEmail email: String, password: String)
  var registerUser: RegisterUser? { get }
  var delegate: RegisterViewModelDelegate? { get set }
}

protocol RegisterViewModelDelegate: class {
  func registerViewModelDelegateDidSuccessRegister(viewModel: RegisterViewModel)
  func registerViewModelDelegateDidFailRegister(viewModel: RegisterViewModel, error: String)
}

class RegisterViewModel: RegisterViewModelType {
    
  var registerUser: RegisterUser?
    
  weak var delegate: RegisterViewModelDelegate?
  
  private let networkManager: BuddeeAPI
  init(networkManager: BuddeeAPI = BuddeeNetworkService()) {
    self.networkManager = networkManager
    
  }
    
  func createRegisterUser(withFirstName firstName: String,
                          lastName: String,
                          mobileNumber: String) {
    let registerUser = RegisterUser()
    registerUser.firstName = firstName
    registerUser.lastName = lastName
    registerUser.mobile = mobileNumber
        
    self.registerUser = registerUser
  }
    
  func updateRegisterUser(withEmail email: String, password: String) {
    registerUser?.email = email
    registerUser?.password = password
  }
    
  func registerUserToAPI() {
    delegate?.registerViewModelDelegateDidSuccessRegister(viewModel: self)
//    if let registerUser = registerUser {
//      networkManager.register(register: registerUser) { [weak self] (response) in
//        guard let self = self else { return }
//        switch response {
//        case let .success(result):
//          print(result)
//          self.delegate?.registerViewModelDelegateDidSuccessRegister(viewModel: self)
//        case let .error(error):
//          print(error)
//          self.delegate?.registerViewModelDelegateDidFailRegister(viewModel: self, error: error)
//        }
//      }
//    }
  }
}
