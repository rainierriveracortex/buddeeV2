//
//  DashboardMenuViewController.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import UIKit

class DashboardMenuViewController: UIViewController {

  @IBOutlet weak private var tableView: UITableView!
  
  private var viewModel = DashboardMenuViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableView()
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(R.nib.dashboardMenuCellTableViewCell)
    tableView.isScrollEnabled = false
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.estimatedRowHeight = 59
    tableView.backgroundColor = .white
  }

}

extension DashboardMenuViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dashboardMenuCellTableViewCell, for: indexPath) else {
      fatalError("Could not find cell")
    }
    let index = indexPath.row
    let cellViewModel = DashboardMenuCellTableViewModel(title: viewModel.titlePerRow[index],
                                                        image: viewModel.imagesPerRow[index])
    cell.viewModel = cellViewModel
    cell.backgroundColor = .white
    cell.bindViewModel()
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    if viewModel.titlePerRow[indexPath.row].lowercased() == "sign out".lowercased() {
      viewModel.signOut(view: view)
    }
  }
  
}
