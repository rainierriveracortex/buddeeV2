//
//  RegisterViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 04/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class RegisterNameViewController: UIViewController {

    @IBOutlet weak private var firstNameTextField: UITextField!
    @IBOutlet weak private var lastNameTextField: UITextField!
    @IBOutlet weak private var mobileTextField: UITextField!
    
    private var viewModel: RegisterViewModelType = RegisterViewModel()
    
    private struct Constant {
        static let backArrowImage = R.image.backarrow()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
        configureTextField()
    }
    
    private func configureTextField() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        mobileTextField.delegate = self
    }
    
    private func showNextScreen() {
        guard let registerEmailViewController = R.storyboard.main.registerEmailViewController() else {
            fatalError("cannot find register Email")
        }
        registerEmailViewController.viewModel = viewModel
        navigationBarUpdateThemeBackButton()
        navigationController?.pushViewController(registerEmailViewController, animated: true)
    }
    
    @IBAction private func nextAction(_ sender: AnyObject) {
        
        viewModel.createRegisterUser(withFirstName: firstNameTextField.text!,
                                     lastName: lastNameTextField.text!,
                                     mobileNumber: mobileTextField.text!)
        
        showNextScreen()
    }

}

extension RegisterNameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if firstNameTextField == textField {
            lastNameTextField.becomeFirstResponder()
        } else if lastNameTextField == textField {
            mobileTextField.becomeFirstResponder()
        } else if mobileTextField == textField {
            showNextScreen()
        }
        return true
    }
    
}

