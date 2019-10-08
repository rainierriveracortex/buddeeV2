//
//  File.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

final class AlertManager {
  static func defaultAlert() -> AlertProtocol {
    return AlertHelper()
  }
}

protocol AlertProtocol {
  func addDestructiveAction(title: String?, handler: ((UIAlertAction) -> Void)?) -> Self
  func addDefaultAction(title: String?, handler: ((UIAlertAction) -> Void)?) -> Self
  func addCancelAction(title: String?, handler: ((UIAlertAction) -> Void)?) -> Self
  func show(fromViewController: UIViewController, title: String?, message: String?, style: UIAlertController.Style)
}


class AlertHelper: AlertProtocol {
  fileprivate lazy var alertActions = [UIAlertAction]()
  
  func show(fromViewController viewController: UIViewController, title: String?, message: String?, style: UIAlertController.Style) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
    alertController.addActions(alertActions: alertActions)
    viewController.present(alertController, animated: true, completion: nil)
  }
  
  func addDefaultAction(title: String?, handler: ((UIAlertAction) -> Void)?) -> Self {
    return addAlertAction(title: title, style: .default, handler: handler)
  }
  
  func addDestructiveAction(title: String?, handler: ((UIAlertAction) -> Void)?) -> Self {
    return addAlertAction(title: title, style: .destructive, handler: handler)
  }
  
  func addCancelAction(title: String?, handler: ((UIAlertAction) -> Void)?) -> Self {
    return addAlertAction(title: title, style: .cancel, handler: handler)
  }
  
  fileprivate func addAlertAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)?) -> Self {
    let alertAction = UIAlertAction(title: title, style: style, handler: handler)
    alertActions.append(alertAction)
    return self
  }
}

extension UIAlertController {
  func addActions(alertActions: [UIAlertAction]) {
    for alert in alertActions {
      self.addAction(alert)
    }
  }
}
