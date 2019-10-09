//
//  LoginViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 04/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

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

class LoginViewController: UIViewController {
    
  @IBOutlet weak private var usernameTextField: UITextField!
  @IBOutlet weak private var passwordTextField: UITextField!
  
  private var isFormValid: Bool {
    return usernameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
  }
  
  private let viewModel = LoginViewModel()
  
  private struct Constant {
    static let backArrowImage = R.image.backarrow()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
      
    hideKeyboardWhenTappedAround()
    configureTextField()
    configureViewModel()
    setRootViewController()
    
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
  }
    
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
        
    setupNavigationBar()
  }
  
  private func configureViewModel() {
    viewModel.delegate = self
  }
  
  private func configureTextField() {
    usernameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  private func setRootViewController() {
    if let rootVC = navigationController?.viewControllers.first {
      let initialNavigation = R.storyboard.main.initialNavigationViewController()
     navigationController?.viewControllers = [rootVC, self]
    }
  }
    
  private func setupNavigationBar() {
    self.navigationController?.view.backgroundColor = .white
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    
    let yourBackImage = Constant.backArrowImage
    self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
  }
  
  @IBAction private func loginAction(_ sender: AnyObject) {
    guard isFormValid else {
      if usernameTextField.text?.isEmpty == true {
        showAlert(title: "Please fill up Username field", message: nil)
      } else {
        showAlert(title: "Please fill up Password field", message: nil)
      }
      return
    }
    
    let userName = usernameTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    viewModel.login(username: userName, password: password)
  }
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    
    if textField == usernameTextField {
      passwordTextField.becomeFirstResponder()
    } else if textField == passwordTextField {
      loginAction(self)
    }
    return true
  }
  
}


extension LoginViewController: LoginViewModelDelegate {
  func loginViewModelDelegateDidSuccessLogin(viewModel: LoginViewModel) {
    
  }
  
  func loginViewModelDelegateDidErrorLogin(viewModel: LoginViewModel, error: String) {
    showAlert(title: error, message: nil)
  }
  
  func loginViewModelDelegateUpdateLoadingState(viewModel: LoginViewModel, isLoading: Bool) {
    
  }
}
