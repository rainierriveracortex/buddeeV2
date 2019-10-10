//
//  DashboardMenuCellTableViewCell.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class DashboardMenuCellTableViewCell: UITableViewCell {

  @IBOutlet weak private var logoImageView: UIImageView!
  @IBOutlet weak private var menuTitleLabel: UILabel!
  
  var viewModel: DashboardMenuCellTableViewModel!
  
  func bindViewModel() {
    menuTitleLabel.text = viewModel.title
    logoImageView.image = viewModel.image
  }
    
}
