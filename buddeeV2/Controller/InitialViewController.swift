//
//  ViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 03/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

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

    var sample: String {
        return ""
    }
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

class InitialViewController: UIViewController {

    private var viewModel: InitialType!
    private var slideViews = [SlideView]()
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
           scrollView.contentOffset.y = 0
        }
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
         let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
         
         // vertical
         let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
         let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
         
         let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
         let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
         
        
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
           
         if(percentOffset.x > 0 && percentOffset.x <= 0.333) {
              slideViews[0].imageView.transform = CGAffineTransform(scaleX: (0.333-percentOffset.x)/0.333, y: (0.333-percentOffset.x)/0.333)
              slideViews[1].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.333, y: percentOffset.x/0.333)
                      
        } else if(percentOffset.x > 0.333 && percentOffset.x <= 0.666) {
              slideViews[1].imageView.transform = CGAffineTransform(scaleX: (0.666-percentOffset.x)/0.333, y: (0.666-percentOffset.x)/0.333)
              slideViews[2].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.666, y: percentOffset.x/0.666)
                      
        } else if(percentOffset.x > 0.666 && percentOffset.x <= 0.999) {
              slideViews[2].imageView.transform = CGAffineTransform(scaleX: (0.999-percentOffset.x)/0.333, y: (0.999-percentOffset.x)/0.333)
              slideViews[3].imageView.transform = CGAffineTransform(scaleX: percentOffset.x/0.999, y: percentOffset.x/0.999)
                      
        }
    }
}
