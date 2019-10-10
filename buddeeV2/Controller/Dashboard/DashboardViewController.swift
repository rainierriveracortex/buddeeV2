//
//  DashboardViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 09/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
  
  var viewModel: DashboardViewModel = DashboardViewModel()
  
  @IBOutlet weak private var segmentedControl: UISegmentedControl!
  @IBOutlet weak private var topContainerView: UIView!
  @IBOutlet weak private var collectionView: UICollectionView!
  @IBOutlet weak private var menuBarButton: UIBarButtonItem!
  @IBOutlet weak private var allAirconSwitch: UISwitch!
  @IBOutlet weak private var deviceConnectedLabel: UILabel!
  
  private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    viewModel.delegate = self
    requestAPI()
    
    setupCollectionView()
    setupViews()
    setupRevealController()
  }
  
  private func requestAPI () {
    viewModel.getProfile()
    viewModel.getDevices()
  }
  
  private func setupRevealController() {
    if self.revealViewController() != nil {
      menuBarButton.target = self.revealViewController()
      menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
      view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer())
    }
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.backgroundColor = .buddeeLightGrayColor
    
    collectionView.register(R.nib.dashboardAllCollectionViewCell)
  }
  
  private func setupViews() {
    segmentedControl.selectedSegmentTintColor = .themeColor
    
    allAirconSwitch.onTintColor = .themeColor
    allAirconSwitch.isOn = viewModel.isAllSwitchOn
    setupDevicesConnectedText()
    
    navigationItem.title = viewModel.navigationTitle
    navigationController?.navigationBar.barTintColor = UIColor.themeColor
    
    topContainerView.roundTopCorners()
    allAirconSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
  }
  
  private func setupDevicesConnectedText() {
    deviceConnectedLabel.text = viewModel.devicesConnectedText
  }
  
  @objc func switchChanged(mySwitch: UISwitch) {
    let value = allAirconSwitch.isOn
    viewModel.turnAllPlug(plugState: PlugState.plugState(isOn: value))
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
    
    cell.viewModel = DashboardAllCollectionViewCellViewModel(device: viewModel.currentDevice(row: indexPath.row))
    cell.bindViewModel()
    cell.delegate = self
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

extension DashboardViewController: DashboardAllCollectionViewCellDelegate {
  func dashboardAllCollectionViewCellDelegateTurnPlug(_ cell: DashboardAllCollectionViewCell, plugState: PlugState, device: Device) {
    viewModel.turnPlug(plugState: plugState, device: device)
  }
}

extension DashboardViewController: DashboardViewModelDelegate {
  func dashboardViewModelDelegateReloadCollectionView(_ viewModel: DashboardViewModel) {
    collectionView.reloadData()
    setupDevicesConnectedText()
    allAirconSwitch.isOn = viewModel.isAllSwitchOn
  }
  
}
