//
//  LoginViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 04/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let yourBackImage = UIImage(named: "backarrow")
        self.navigationController?.navigationBar.backIndicatorImage = yourBackImage
    }

}
