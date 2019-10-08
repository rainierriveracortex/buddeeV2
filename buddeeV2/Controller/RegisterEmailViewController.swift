//
//  RegisterEmailViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 07/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class RegisterEmailViewController: UIViewController {

  @IBOutlet weak private var emailTextField: UITextField!
  @IBOutlet weak private var passwordTextField: UITextField!
  @IBOutlet weak private var confirmPasswordTextField: UITextField!
  
  var viewModel: RegisterViewModelType! // this should come from RegisterNameViewController
  
  private var isFormValid: Bool {
    return emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && confirmPasswordTextField.text?.isEmpty == false && isValidPassword
  }
  
  private var isValidPassword: Bool {
    return passwordTextField.text == confirmPasswordTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
      
    configureViewModel()
    configureTextField()
  }
  
  private func configureViewModel() {
    guard viewModel != nil else {
      fatalError("must have viewModel")
    }
    
    viewModel.delegate = self
  }
  
  private func configureTextField() {
    emailTextField.delegate = self
    passwordTextField.delegate = self
    confirmPasswordTextField.delegate = self
  }
    
    
  private func registerUser() {
    guard isFormValid else {
        return
    }
    viewModel.updateRegisterUser(withEmail: emailTextField.text!,
                                 password: passwordTextField.text!)
    viewModel.registerUserToAPI()
  }
    
  @IBAction private func registerAction(_ sender: AnyObject) {
    registerUser()
  }

}

extension RegisterEmailViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
      
    if textField == emailTextField {
      passwordTextField.becomeFirstResponder()
    } else if passwordTextField == textField {
      confirmPasswordTextField.becomeFirstResponder()
    } else if confirmPasswordTextField == textField {
      registerAction(self)
    }
    return true
  }
  
}

extension RegisterEmailViewController: RegisterViewModelDelegate {
  func registerViewModelDelegateDidSuccessRegister(viewModel: RegisterViewModel) {
    NotificationCenter.default.post(name: .didRegister, object: nil)
    navigationController?.popToRootViewController(animated: true)
  }
  
  func registerViewModelDelegateDidFailRegister(viewModel: RegisterViewModel, error: String) {
    showAlert(title: error, message: nil)
  }
    
}
