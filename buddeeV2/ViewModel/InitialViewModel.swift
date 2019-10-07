//
//  InitialViewModel.swift
//  buddeeV2
//
//  Created by jlrivera on 07/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

protocol InitialType {
    var numberOfPages: Int { get }
    var delegate: InitialViewModelDelegate? { get set }
    var slideTitles: [String] { get }
    var slideDescription: [String] { get }
    func login()
    func register()
    func facebookLogin()
}

protocol InitialViewModelDelegate: class {
    func initialViewModelDelegateDidLogin()
    func initialViewModelDelegateDidRegister()
    func initialViewModelDelegateDidFacebook()
}


class InitialViewModel: InitialType {
    
    weak var delegate: InitialViewModelDelegate?

    var numberOfPages: Int {
        return 4
    }
    
    var loginText: String {
        return "Login"
    }
    
    var registerText: String {
        return "Register"
    }
    
    var facebookText: String {
        return "Use facebook login"
    }
    
    var slideTitles: [String] {
        return ["Remote control",
                "Schedule Function",
                "Monitor Consumption",
                "Alerts"]
    }
    
    var slideDescription: [String] {
        return ["Using your phone  you can control your appliances from anywhere in your home.",
                "Schedule operating hours of each device easily to have more control over costs.",
                "With real-time consumption monitoring, you will know which appliances to control.",
                "Set and receive alerts once your reach the threshold for each device to control your consumption."]
    }
    
    func register() {
        delegate?.initialViewModelDelegateDidRegister()
    }
    
    func login() {
        delegate?.initialViewModelDelegateDidLogin()
    }
    
    func facebookLogin() {
        delegate?.initialViewModelDelegateDidFacebook()
    }
}
