//
//  UIWindow+Transition.swift
//  TwitterDM
//
//  Created by John Harold Rasco on 19/08/2019.
//  Copyright © 2019 JHR. All rights reserved.
//

import UIKit

enum RootViewSwapAnimationType {
  case push
  case pop
  case present
  case dismiss
  case fade
  case none
}

extension UIWindow {

  func swapRootViewController(_ viewController: UIViewController,
                              animationType: RootViewSwapAnimationType,
                              completion: (() -> Void)?) {
    guard let rootViewController = rootViewController else { return }

    let width = rootViewController.view.frame.size.width;
    let height = rootViewController.view.frame.size.height;

    var newRootViewControllerStartAnimationFrame: CGRect?
    var rootViewControllerEndAnimationFrame: CGRect?

    var shouldAnimateNewRootViewController = true

    switch animationType {
    case .push:
      newRootViewControllerStartAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
      rootViewControllerEndAnimationFrame = CGRect(x: 0 - width / 4, y: 0, width: width, height: height)
    case .pop:
      newRootViewControllerStartAnimationFrame = CGRect(x: 0 - width / 4, y: 0, width: width, height: height)
      rootViewControllerEndAnimationFrame = CGRect(x: width, y: 0, width: width, height: height)
      shouldAnimateNewRootViewController = false
    case .present:
      newRootViewControllerStartAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
    case .dismiss:
      rootViewControllerEndAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
      shouldAnimateNewRootViewController = false
    case .fade:
      newRootViewControllerStartAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
      rootViewControllerEndAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
      shouldAnimateNewRootViewController = false
    case .none:
      newRootViewControllerStartAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
      rootViewControllerEndAnimationFrame = CGRect(x: 0, y: height, width: width, height: height)
      shouldAnimateNewRootViewController = false
    }

    viewController.view.frame = newRootViewControllerStartAnimationFrame ?? CGRect(x: 0, y: 0, width: width, height: height)

    addSubview(viewController.view)

    if !shouldAnimateNewRootViewController {
      bringSubviewToFront(rootViewController.view)
    }

    if animationType == .none {
      setRootViewController(viewController)
      completion?()
    } else if animationType == .fade {
      UIView.transition(with: self,
                        duration: 0.3,
                        options: .transitionCrossDissolve,
                        animations: {
                          let oldState = UIView.areAnimationsEnabled
                          UIView.setAnimationsEnabled(false)
                          self.setRootViewController(viewController)
                          UIView.setAnimationsEnabled(oldState)
      }, completion: { _ in
        completion?()
      })
    } else {
      UIView.animate(withDuration: 0.3,
                     delay: 0,
                     options: [.curveEaseOut, .beginFromCurrentState],
                     animations: {
                      if let rootViewControllerEndAnimationFrame = rootViewControllerEndAnimationFrame {
                        rootViewController.view.frame = rootViewControllerEndAnimationFrame
                      }
                      viewController.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
      }, completion: { _ in
        self.setRootViewController(viewController)
        completion?()
      })
    }
  }

  private func setRootViewController(_ viewController: UIViewController) {
    DispatchQueue.main.async {
      self.rootViewController = viewController
      self.makeKeyAndVisible()
    }
  }

}

