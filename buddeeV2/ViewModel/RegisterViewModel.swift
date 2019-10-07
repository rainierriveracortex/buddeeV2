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
    func registerViewModelDelegateDidRegister(viewModel: RegisterViewModel, error: NSError?)
}

class RegisterViewModel: RegisterViewModelType {
    
    var registerUser: RegisterUser?
    
    weak var delegate: RegisterViewModelDelegate?
    
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
        // request to API
        delegate?.registerViewModelDelegateDidRegister(viewModel: self, error: nil)
    }
}
