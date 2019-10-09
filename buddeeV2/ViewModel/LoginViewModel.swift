//
//  LoginViewModel.swift
//  buddeeV2
//
//  Created by jlrivera on 09/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: class {
  func loginViewModelDelegateDidSuccessLogin(viewModel: LoginViewModel)
  func loginViewModelDelegateDidErrorLogin(viewModel: LoginViewModel, error: String)
  func loginViewModelDelegateUpdateLoadingState(viewModel: LoginViewModel, isLoading: Bool)
}

class LoginViewModel {
  weak var delegate: LoginViewModelDelegate?
  
  private var networkService: BuddeeAPI
  init(networkService: BuddeeAPI = BuddeeNetworkService()) {
    self.networkService = networkService
  }
  
  func login(username: String, password: String) {
    let login = Login(username: username, password: password)
    networkService.login(login: login) { [weak self] (response) in
      guard let self = self else { return }
      switch response {
      case .success(_):
        self.delegate?.loginViewModelDelegateDidSuccessLogin(viewModel: self)
      case let .error(error):
        self.delegate?.loginViewModelDelegateDidErrorLogin(viewModel: self, error: error)
      }
    }
  }
}
