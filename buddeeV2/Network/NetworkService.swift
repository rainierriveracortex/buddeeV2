//
//  NetworkService.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {

  // Basic alamofire configuration setup
  static var manager: Alamofire.Session = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 30.0
    configuration.urlCache = nil
    return Alamofire.Session(configuration: configuration)
  }()

  // since we are not handling the authentication bearer
  // we leave it empty as default header
  
  func defaultHeaders() -> HTTPHeaders {
    let headers: [String: String] = [:]
    return HTTPHeaders(headers)
  }
}
