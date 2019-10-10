//
//  GetAllDevicesResponse.swift
//  buddeeV2
//
//  Created by jlrivera on 10/10/2019.
//  Copyright © 2019 jlrivera. All rights reserved.
//

import Foundation

// MARK: - GetDevicesResponse
class AllDevices: Codable {
    let device: [Device]
    let sharedDevice: [String]?
    let error: Int
    let message: String

    enum CodingKeys: String, CodingKey {
        case device
        case sharedDevice = "shared_device"
        case error, message
    }
}

// MARK: - Device
class Device: Codable {
    let deviceName, serial, model, applianceName: String
    let applianceType, misc, locationName, province: String
    let city, street, roomName, dateRegistered: String
    let timeRegistered, dateUpdated, timeUpdated, macAddress: String
    let name, blMACAddress, wifiState, powerState: String
    let dateNow, timeNow, otaStatus, otaTimeout: String
    let dateOfPurchase, applianceBrand, applianceModel, firmware: String

    enum CodingKeys: String, CodingKey {
        case deviceName = "device_name"
        case serial, model
        case applianceName = "appliance_name"
        case applianceType = "appliance_type"
        case misc
        case locationName = "location_name"
        case province, city, street
        case roomName = "room_name"
        case dateRegistered = "date_registered"
        case timeRegistered = "time_registered"
        case dateUpdated = "date_updated"
        case timeUpdated = "time_updated"
        case macAddress = "mac_address"
        case name
        case blMACAddress = "bl_mac_address"
        case wifiState = "wifi_state"
        case powerState = "power_state"
        case dateNow = "date_now"
        case timeNow = "time_now"
        case otaStatus = "ota_status"
        case otaTimeout = "ota_timeout"
        case dateOfPurchase = "date_of_purchase"
        case applianceBrand = "appliance_brand"
        case applianceModel = "appliance_model"
        case firmware
    }
}
