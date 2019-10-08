//
//  UIViewController+extension.swift
//  buddeeV2
//
//  Created by jlrivera on 04/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
    
  func navigationBarUpdateThemeBackButton() {
    let backItem = UIBarButtonItem()
    backItem.title = ""
    navigationItem.backBarButtonItem?.image = R.image.backarrow()
    navigationItem.backBarButtonItem = backItem
    navigationController?.navigationBar.isHidden = false
  }
  
  func showAlert(title: String?, message: String?) {
    AlertManager.defaultAlert().addDefaultAction(title: "Ok", handler: nil)
      .show(fromViewController: self, title: title, message: message, style: .alert)
  }
}
