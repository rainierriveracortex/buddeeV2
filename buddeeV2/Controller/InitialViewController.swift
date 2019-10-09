//
//  ViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 03/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

  private var viewModel: InitialType!
  
  private var slideViews = [SlideView]()
  
  @IBOutlet private weak var scrollView: UIScrollView!
  @IBOutlet private weak var pageControl: UIPageControl!
  
  private var presentLogin: Bool = false // flag to present login
  
  var timer: Timer!
  
  private struct Constant {
    static let timerCount: TimeInterval = 4
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewModel()
    setupViews()
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .darkContent
  }
  
  private func setupViewModel() {
    viewModel = InitialViewModel()
    viewModel.delegate = self
  }
  
  private func setupTimer() {
      timer = Timer.scheduledTimer(timeInterval: Constant.timerCount,
                                  target: self,
                                  selector: #selector(timerAction),
                                  userInfo: nil,
                                  repeats: true)
       
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
      
     self.navigationController?.view.backgroundColor = .white
     self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
     self.navigationController?.navigationBar.shadowImage = UIImage()
     self.navigationController?.navigationBar.isTranslucent = true
      
      if presentLogin {
        viewModel.login()
        presentLogin = false
      }
     
      setupTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
      
    timer.invalidate()
    
    let backItem = UIBarButtonItem()
    backItem.title = ""
    navigationItem.backBarButtonItem?.image = R.image.backarrow()
    navigationItem.backBarButtonItem = backItem
    navigationController?.navigationBar.isHidden = false
  }
  
  private func setupViews() {
    slideViews = createSlides()
    scrollView.delegate = self
    
    pageControl.numberOfPages = slideViews.count
    pageControl.currentPage = 0
    pageControl.pageIndicatorTintColor  = .unselectedPageColor
    pageControl.currentPageIndicatorTintColor = .selectedPageColor
    
    setupSlideScrollView(slideViews: slideViews)
  }
  
  private func setupSlideScrollView(slideViews: [SlideView]) {
    scrollView.frame = CGRect(x: 0, y: 0,
                              width: view.frame.width,
                              height: view.frame.height)
    scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slideViews.count),
                                    height: view.frame.height)
    scrollView.isPagingEnabled = true
    
    for i in 0 ..< slideViews.count {
      slideViews[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                    y: 0,
                                    width: view.frame.width,
                                    height: view.frame.height)
      scrollView.addSubview(slideViews[i])
    }
  }
  
  func createSlides() -> [SlideView] {
    var slides = [SlideView]()
    for (index, _) in (1...viewModel.numberOfPages).enumerated() {
      let slide = Bundle.main.loadNibNamed("SlideView", owner: self, options: nil)?.first as! SlideView
      slide.imageView.image = UIImage(named: "initialimage\(index + 1)")
      slide.titleLabel.text = viewModel.slideTitles[index]
      slide.descriptionLabel.text = viewModel.slideDescription[index]
        
      slides.append(slide)
    }
    
    return slides
  }

  @IBAction private func loginButtonAction() {
    viewModel.login()
  }
  
  @IBAction private func registerButtonAction() {
    viewModel.register()
  }
  
  @IBAction private func facebookButtonAction() {
    viewModel.facebookLogin()
  }

}

extension InitialViewController: InitialViewModelDelegate {
  func initialViewModelDelegateDidLogin() {
    guard let loginViewController = R.storyboard.main.loginViewController() else {
      fatalError("Login View controller not found")
    }
    navigationController?.pushViewController(loginViewController, animated: true)
  }
  
  func initialViewModelDelegateDidFacebook() {
      // login with faceboook
  }
  
  func initialViewModelDelegateDidRegister() {
    guard let registerNameViewController = R.storyboard.main.registerNameViewController() else {
      fatalError("Register View controller not found")
    }
    navigationController?.pushViewController(registerNameViewController, animated: true)
  }
  
}


extension InitialViewController: UIScrollViewDelegate {
  
  @objc func timerAction() {
    DispatchQueue.main.async {
      UIView.animate(withDuration: 1.0) {
        if self.pageControl.currentPage == 3 {
          self.scrollView.contentOffset.x = 0
        } else {
          self.scrollView.contentOffset.x = self.view.frame.width * CGFloat(self.pageControl.currentPage + 1)
        }
      }
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
      scrollView.contentOffset.y = 0
    }
    let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
    pageControl.currentPage = Int(pageIndex)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    timer.invalidate()
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    setupTimer()
  }
}
