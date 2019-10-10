//
//  DashboardViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 09/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

protocol DashboardViewModelDelegate: class {
  func dashboardViewModelDelegateReloadCollectionView(_ viewModel: DashboardViewModel)
}

class DashboardViewModel {
  
  let user: User
  
  var networkManager: BuddeeAPI
  
  weak var delegate: DashboardViewModelDelegate?
  private var devices = [Device]()
  
  init(networkManager: BuddeeAPI = BuddeeNetworkService()) {
    guard let user = AppHelper.shared.getCurrentUser() else {
      fatalError("Could not find user")
    }
    self.networkManager = networkManager
    self.user = user
  }
  
  var numberofRows: Int {
    return devices.count
  }
  
  var numberofSections: Int {
    return 1
  }
  
  var navigationTitle: String {
    return "Dashboard"
  }
  
  var devicesConnectedText: String {
    return "\(devices.count) Devices Connected"
  }
  
  var isAllSwitchOn: Bool {
    return (devices.first { (device) -> Bool in
      let plugState = PlugState.plugState(string: device.powerState)
      return plugState == PlugState.on
      } != nil)
  }
  
  func currentDevice(row: Int) -> Device {
    return devices[row]
  }
  
  func getProfile() {
    networkManager.getProfile(user: user) { [weak self] response in
      guard let self = self else { return }
      
      switch response {
      case let .success(UserProfile): break
     //   print(UserProfile)
      case let .error(error): break
   //     print(error)
      }
    }
  }
  
  func getDevices() {
    networkManager.getAllDevices(user: user) { [weak self] response in
      guard let self = self else { return }
      switch response {
      case let .success(allDevices):
        self.devices = allDevices.device
        print("👹 \(self.isAllSwitchOn)")
        self.delegate?.dashboardViewModelDelegateReloadCollectionView(self)
      case let .error(error):
        print(error)
      }
    }
  }
  
  func turnPlug(plugState: PlugState, device: Device) {
    networkManager.turnPlug(plugState: plugState, user: user, device: device) { [weak self] response in
      switch response {
      case let .success(plugResponse):
        print("👺 \(plugResponse)")
      case let .error(error):
        print("👺 \(error)")
      }
    }
  }
  
  func turnAllPlug(plugState: PlugState) {
    for (index, device) in devices.enumerated() {
      networkManager.turnPlug(plugState: plugState, user: user, device: device) { [weak self] response in
        guard let self = self else { return }
        switch response {
        case let .success(plugResponse):
          print("👹 Devices count \(self.devices.count)")
          if index == self.devices.count - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.getDevices()
            }
          }
        case let .error(error):
          print("👹 \(error)")
        }
      }
    }
  }

}

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
    
    viewModel.getProfile()
    viewModel.getDevices()
    viewModel.delegate = self
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.backgroundColor = .buddeeLightGrayColor
    
    collectionView.register(R.nib.dashboardAllCollectionViewCell)
    setupViews()
    
    topContainerView.roundTopCorners()
    
    navigationItem.title = "Dashboard"
    navigationController?.navigationBar.barTintColor = UIColor.themeColor
    
    setupDevicesConnectedText()
    
    if self.revealViewController() != nil {
      menuBarButton.target = self.revealViewController()
      menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
      view.addGestureRecognizer(self.revealViewController()!.panGestureRecognizer())
    }
    allAirconSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
  }
  
  private func setupViews() {
    segmentedControl.selectedSegmentTintColor = .themeColor
    allAirconSwitch.onTintColor = .themeColor
    allAirconSwitch.isOn = viewModel.isAllSwitchOn
  }
  
  private func setupDevicesConnectedText() {
    print(viewModel.devicesConnectedText)
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
  }
  
}
