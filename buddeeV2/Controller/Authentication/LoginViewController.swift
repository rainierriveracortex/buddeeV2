//
//  LoginViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 04/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

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

  
  // MARK: Overrides
  
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
  
  // MARK: Private method
  
  private func configureViewModel() {
    viewModel.delegate = self
  }
  
  private func configureTextField() {
    usernameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  private func setRootViewController() {
    if let rootVC = navigationController?.viewControllers.first {
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
  
  // MARK: Actions
  
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
    // show Dashboard
  }
  
  func loginViewModelDelegateDidErrorLogin(viewModel: LoginViewModel, error: String) {
    showAlert(title: error, message: nil)
  }
  
  func loginViewModelDelegateUpdateLoadingState(viewModel: LoginViewModel, isLoading: Bool) {
    // show loading state
  }
}
