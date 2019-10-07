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
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewModel()
        setupViews()
        
        timer = Timer.scheduledTimer(timeInterval: 4,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupViewModel() {
        viewModel = InitialViewModel()
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       self.navigationController?.view.backgroundColor = .white
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       self.navigationController?.navigationBar.shadowImage = UIImage()
       self.navigationController?.navigationBar.isTranslucent = true
       
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
            slideViews[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0,
                                         width: view.frame.width,
                                         height: view.frame.height)
            scrollView.addSubview(slideViews[i])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem?.image = R.image.backarrow()
        navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.isHidden = false
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
    func initialViewModelDelegateDidFacebook() {
        // login with faceboook
    }
    
    func initialViewModelDelegateDidLogin() {
        // present login screen
    }
    
    func initialViewModelDelegateDidRegister() {
        // present register screen
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
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
}
