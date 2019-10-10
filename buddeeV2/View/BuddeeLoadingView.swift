
import UIKit

class BuddeeLoadingView: UIView {
  @IBOutlet private weak var loadingTextLabel: UILabel!
  @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    customInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    customInit()
  }

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    customInit()
  }

  private func customInit() {
    if let view = R.nib.buddeeLoadingView.firstView(owner: self) {
      view.translatesAutoresizingMaskIntoConstraints = false
      addSubview(view)

      NSLayoutConstraint.activate([
        leadingAnchor.constraint(equalTo: view.leadingAnchor),
        trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bottomAnchor.constraint(equalTo: view.bottomAnchor),
        topAnchor.constraint(equalTo: view.topAnchor)
        ])

      view.addGestureRecognizer(UITapGestureRecognizer())

    }
  }

  /// animate the loading view
  func startAnimating() {
    activityIndicator.startAnimating()
  }

  /// stop animating loading view
  func stopAnimating() {
    activityIndicator.stopAnimating()
  }

}
