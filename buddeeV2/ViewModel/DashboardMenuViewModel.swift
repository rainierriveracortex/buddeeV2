//
//  DashboardMenuViewModel.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

class DashboardMenuViewModel {
  var numberOfSections: Int {
    return 1
  }
  
  var numberOfRows: Int {
    return 5
  }
  
  var titlePerRow: [String] {
    return ["Buddee Portal", "AC Services", "Help Center", "About Us", "Sign Out"]
  }
  
  var imagesPerRow: [UIImage?] {
    return [R.image.menuBuddeePortal(), R.image.menuIconServices(), R.image.menuHelpCenter(), R.image.menuAbout(), R.image.menuSignout()]
  }
  
  func signOut() {
    AppHelper.shared.deleteCurrentUser()
    guard let vc = R.storyboard.main.initialViewController() else {
      fatalError("No initial controller")
    }
    let navigationController = InitialNavigationViewController(rootViewController: vc)
    
    UIApplication.shared.windows.first?.swapRootViewController(navigationController,
                                                               animationType: .dismiss,
                                                               completion: nil)
  }
  
}
