//
//  UserProfile.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

// MARK: - UserProfile
struct UserProfile: Codable {
    let username, emailAddress, firstName, lastName: String
    let birthDate, gender, platform, mobileNumber: String

    enum CodingKeys: String, CodingKey {
        case username
        case emailAddress = "email_address"
        case firstName = "first_name"
        case lastName = "last_name"
        case birthDate = "birth_date"
        case gender, platform
        case mobileNumber = "mobile_number"
    }
}

