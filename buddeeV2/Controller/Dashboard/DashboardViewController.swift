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
    return 4
  }
  
  var numberofSections: Int {
    return 1
  }
}

class DashboardViewController: UIViewController {

  @IBOutlet weak private var tableView: UITableView!
  
  private var viewModel: DashboardViewModel = DashboardViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupConfigure()
  }

  func setupConfigure() {
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberofSections
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberofRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = "Hello"
    return cell
  }
  
}

