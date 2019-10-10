//
//  DashboardAllCollectionViewCell.swift
//  buddeeV2
//
//  Created by jlrivera on 09/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

protocol DashboardAllCollectionViewCellDelegate: class {
  func dashboardAllCollectionViewCellDelegateTurnPlug(_ cell: DashboardAllCollectionViewCell, plugState: PlugState, device: Device)
}

class DashboardAllCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak private var airconSwitch: UISwitch!
  @IBOutlet weak private var roomNameLabel: UILabel!
  @IBOutlet weak private var powerStateLabel: UILabel!
  @IBOutlet weak private var wifiImageView: UIImageView!
  @IBOutlet weak private var bluetoothImageView: UIImageView!
  
  var viewModel: DashboardAllCollectionViewCellViewModel!
  
  weak var delegate: DashboardAllCollectionViewCellDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
      backgroundColor = .white
      commonInit()
    }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    commonInit()
  }
  
  private func commonInit() {
    
    airconSwitch.setScale(width: 36, height: 17) // size based on zeplin
    airconSwitch.onTintColor = .themeColor
    
    airconSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
  }
  
  func bindViewModel() {
    roomNameLabel.text = viewModel.locatioName
    airconSwitch.isOn = viewModel.isOn
    wifiImageView.image = viewModel.wifiImage
    updatePowerStateLabel()
  }
  
  func updatePowerStateLabel() {
    powerStateLabel.text = viewModel.powerStateString
    if viewModel.isOn {
      powerStateLabel.textColor = .systemGreen
    } else {
      powerStateLabel.textColor = .systemRed
    }
  }

  @objc func switchChanged(mySwitch: UISwitch) {
    let value = airconSwitch.isOn
    delegate?.dashboardAllCollectionViewCellDelegateTurnPlug(self,
                                                             plugState: PlugState.plugState(isOn: value),
                                                             device: viewModel.device)
  }
}
