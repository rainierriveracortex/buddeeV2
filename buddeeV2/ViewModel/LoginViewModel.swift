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
  
  private var user: User!
  private var networkService: BuddeeAPI
  init(networkService: BuddeeAPI = BuddeeNetworkService()) {
    self.networkService = networkService
  }
  
  func login(username: String, password: String) {
    let login = Login(username: username, password: password)
    delegate?.loginViewModelDelegateUpdateLoadingState(viewModel: self, isLoading: true)
    networkService.login(login: login) { [weak self] (response) in
      guard let self = self else { return }
      self.delegate?.loginViewModelDelegateUpdateLoadingState(viewModel: self, isLoading: false)
      switch response {
      case .success(let loginResponse):
        self.saveUser(userId: loginResponse.userID, phoneId: login.phoneId)
        self.delegate?.loginViewModelDelegateDidSuccessLogin(viewModel: self)
      case let .error(error):
        self.delegate?.loginViewModelDelegateDidErrorLogin(viewModel: self, error: error)
      }
    }
  }
  
  private func saveUser(userId: String, phoneId: String) {
    user = User(userId: userId, phoneId: phoneId)
    AppHelper.shared.saveUser(user: user)
  }
  
  func presentDashboard() {
    guard let revealController = R.storyboard.dashboard.swRevealViewController() else {
      fatalError("Could not find reveal controller")
    }
    UIApplication.shared.windows.first?.swapRootViewController(revealController,
                                                               animationType: .present,
                                                               completion: nil)
  }
}
