//
//  DashboardViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 09/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class DashboardViewModel {
  var numberofRows: Int {
    return 12
  }
  
  var numberofSections: Int {
    return 1
  }
  
  var navigationTitle: String {
    return "Dashboard"
  }
}

class DashboardViewController: UIViewController {
  
  private var viewModel: DashboardViewModel = DashboardViewModel()
  
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak private var topContainerView: UIView!
  @IBOutlet weak private var collectionView: UICollectionView!
  
  private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.backgroundColor = .buddeeLightGrayColor
    
    collectionView.register(R.nib.dashboardAllCollectionViewCell)
    
    topContainerView.roundTopCorners()
    
    navigationItem.title = "Dashboard"
    navigationController?.navigationBar.barTintColor = UIColor.themeColor
  }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    viewModel.numberofRows
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    viewModel.numberofSections
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dashboardAllCollectionViewCell, for: indexPath) else {
      fatalError("Coulld not find cell")
    }
    return cell
  }
  
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    

    let paddingSpace = sectionInsets.left * (2 + 1)
       let availableWidth = view.frame.width - paddingSpace
       let widthPerItem = availableWidth / 2
       
       return CGSize(width: widthPerItem, height: widthPerItem)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 16
  }
}
