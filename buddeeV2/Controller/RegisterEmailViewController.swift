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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension RegisterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}

