//
//  RegisterResponse.swift
//  buddeeV2
//
//  Created by jlrivera on 08/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

// MARK: - RegistrationResponse
struct RegistrationResponse: Codable {
    let userID: String
    let error: Int
    let message, session: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case error, message, session
    }
}
