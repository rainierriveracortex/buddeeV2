//
//  InitialViewModelSpec.swift
//  buddeeV2
//
//  Created by jlrivera on 11/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import buddeeV2

final class TrackListSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("Given a InitialViewModel") {
            let viewModel = InitialViewModel()
          
            context("When there is InitialViewModel available") {
              it("Then it should have correct number of carousel") {
                  expect(viewModel.numberOfPages).to(equal(4))
              }
              
              it("Then it should have correct login button text") {
                  expect(viewModel.loginText).to(equal("Login"))
              }
              
              it("Then it should have correct registration button text") {
                  expect(viewModel.registerText).to(equal("Register"))
              }
              
              it("Then it should have correct log in with facebook button text") {
                  expect(viewModel.facebookText).to(equal("Use facebook login"))
              }
              
              it("Then it should have correct slides text count") {
                expect(viewModel.slideTitles.count).to(equal(4))
              }
              
              it("Then it should have correct slides description text count") {
                expect(viewModel.slideDescription.count).to(equal(4))
              }
            }
        }
    }
}
