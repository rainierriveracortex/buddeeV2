import UIKit

protocol BuddeeLoadingControllerLayoutDelegate: class {
  /// Constraints requested by the loadingView
  ///
  /// - Parameter loadingView: loadingView to be displayed on hostView
  /// - Returns: array of constraints
  func loadingScreenConstraints(_ loadingView: UIView) -> [NSLayoutConstraint]
}

protocol BuddeeLoadingControllerDisplay {
  /// Shows the loading screen by adding it onto the hostView.
  /// - Important:
  /// If multiple calls to showLoadingScreen: is made on the same instance,
  /// loadingView will stay on screen until an equal number of
  /// matching hideLoadingScreen: calls are made.
  /// - Important:
  /// When this function is called, loadingView will get added on top of everything in hostView.
  /// Therefore refrain from making any view-hierarchy changes on hostingView until loading is finished displaying.
  ///
  /// - Parameter animated: should loading screen be animated when it's appearing
  func showLoadingScreen(animated: Bool)

  /// Shows the loading screen by adding it onto the hostView.
  /// - Important:
  /// If multiple calls to showLoadingScreen: is made on the same instance,
  /// loadingView will stay on screen until an equal number of
  /// matching hideLoadingScreen: calls are made.
  ///
  /// - Parameters:
  ///   - animated: should loading screen be animated when it's appearing
  ///   - completion: completionBlock
  func hideLoadingScreen(animated: Bool, completion: (() -> Void)?)
}

extension BuddeeLoadingControllerDisplay {
  func hideLoadingScreen(animated: Bool = true, completion: (() -> Void)? = nil) {
    hideLoadingScreen(animated: animated, completion: completion)
  }

  func showLoadingScreen(animated: Bool = true) {
    showLoadingScreen(animated: animated)
  }

  func show(_ shouldShow: Bool) {
    shouldShow ? showLoadingScreen() : hideLoadingScreen()
  }

}

class BuddeeLoadingController: BuddeeLoadingControllerDisplay {
  private let hostView: UIView
  private weak var delegate: BuddeeLoadingControllerLayoutDelegate?
  private var showCount: Int = 0  // to keep a reference count for show calls

  private lazy var loadingView: BuddeeLoadingView = {
    let view = BuddeeLoadingView(frame: CGRect.zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  init(withHostView hostView: UIView, delegate: BuddeeLoadingControllerLayoutDelegate? = nil) {
    self.hostView = hostView
    self.delegate = delegate
  }

  /// A flag to ignore user interactions during which loading screen is presented. Default is to ignore.
  var ignoresUserInteractionEvents: Bool = true

  func showLoadingScreen(animated: Bool) {
    showCount += 1
    guard loadingView.superview == nil else {
      return
    }

    DispatchQueue.main.async(execute: { [weak self] in
      guard let weakself = self else {
        return
      }

      let duration = animated ? 0.1 : 0.0

      weakself.loadingView.alpha = 0.0
      weakself.hostView.addSubview(weakself.loadingView)
      if let delegate = weakself.delegate {
        NSLayoutConstraint.activate(delegate.loadingScreenConstraints(weakself.loadingView))
      } else {
        NSLayoutConstraint.activate(weakself.defaultConstraints())
      }
      weakself.loadingView.setNeedsLayout()
      weakself.loadingView.startAnimating()

      UIView.animate(withDuration: duration) {
        weakself.loadingView.alpha = 1.0
      }
    })

  }

  func hideLoadingScreen(animated: Bool, completion: (() -> Void)? = nil) {

    showCount -= 1
    // showCount should reach 0 for loading screen to be removed
    if showCount < 0 {
      showCount = 0
    } else {

      DispatchQueue.main.async(execute: { [weak self] in
        guard let weakself = self else {
          return
        }
        let duration = animated ? 0.1 : 0.0
        UIView.animate(withDuration: duration, animations: {
          weakself.loadingView.alpha = 0.3
          weakself.loadingView.removeFromSuperview()
          weakself.loadingView.stopAnimating()
        }, completion: { (_) in
          completion?()
        })
      })
    }
  }

  /// Default constraints for loadingView.
  /// - Important:
  /// When delegate is not set, loadingview assumes default constraints to a window
  ///
  /// - Returns: array of constraints
  private func defaultConstraints() -> [NSLayoutConstraint] {
    return [
      hostView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
      hostView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
      loadingView.topAnchor.constraint(equalTo: hostView.topAnchor),
      loadingView.leftAnchor.constraint(equalTo: hostView.leftAnchor),
      loadingView.rightAnchor.constraint(equalTo: hostView.rightAnchor),
      loadingView.bottomAnchor.constraint(equalTo: hostView.bottomAnchor)
    ]
  }
}
