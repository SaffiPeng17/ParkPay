//
//  ParkingLotInfo.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

// MARK: - Response
struct ParkingLotInfoResponse: Codable {
    let success: Bool
    let data: ParkingLotInfo
}

// Parking Lot Info
struct ParkingLotInfo: Codable, Identifiable {
    let parkID: String
    let area: String
    let name: String
    let summary: String
    let address: String
    let tel: String
    let payex: String
    let serviceTime: String
    let totalCar: Int
    let totalMotor: Int
    let totalBike: Int
    let totalBus: Int
    let totalLargeMotor: Int
    let totalPregnancy: Int
    let totalHandicap: Int
    let totalCharging: Int
    let hasTaxiOneHRFree: Bool
    let hasAED: Bool
    let hasSignalEnhancement: Bool
    let hasElevator: Bool
    let hasPhoneCharge: Bool
    let hasChildPickup: Bool
    let hasHandicapDiscount: Bool
    let entranceCoords: EntranceCoords?
    let coordinate: CoordinateInfo
    let realtime: RealtimeSpaces

    var id: String { parkID }

    enum CodingKeys: String, CodingKey {
        case parkID = "park_id"
        case area
        case name
        case summary
        case address
        case tel
        case payex
        case serviceTime = "service_time"
        case totalCar = "total_car"
        case totalMotor = "total_motor"
        case totalBike = "total_bike"
        case totalBus = "total_bus"
        case totalLargeMotor = "total_large_motor"
        case totalPregnancy = "pregnancy_first"
        case totalHandicap = "handicap_first"
        case totalCharging = "charging_station"
        case hasTaxiOneHRFree = "taxi_one_hr_free"
        case hasAED = "aed_equipment"
        case hasSignalEnhancement = "cell_signal_enhancement"
        case hasElevator = "accessibility_elevator"
        case hasPhoneCharge = "phone_charge"
        case hasChildPickup = "child_pickup_area"
        case hasHandicapDiscount = "handicap_discount"
        case entranceCoords = "entrance_coords"
        case coordinate
        case realtime
    }
}
extension ParkingLotInfo {
    var entrances: [EntranceCoordInfo] {
        entranceCoords?.info ?? []
    }
    var hasMultipleEntrances: Bool {
        entrances.count > 1
    }
}

// Entrance Coordinates
struct EntranceCoords: Codable {
    let info: [EntranceCoordInfo]?

    enum CodingKeys: String, CodingKey {
        case info = "EntrancecoordInfo"
    }
}
struct EntranceCoordInfo: Codable {
    let latitude: String
    let longitude: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case latitude = "Xcod"
        case longitude = "Ycod"
        case address = "Address"
    }
}

// Coordinate Info
struct CoordinateInfo: Codable {
    let latitude: String
    let longitude: String
}

// Realtime Spaces
struct RealtimeSpaces: Codable {
    let totalSpaces: Int
    let availableSpaces: Int
    let fetchedAt: String
}
extension RealtimeSpaces {
    var occupiedSpaces: Int {
        totalSpaces - availableSpaces
    }
    var occupancyRate: Double {
        guard totalSpaces > 0 else { return 0 }
        return Double(occupiedSpaces) / Double(totalSpaces)
    }
    var isAvailable: Bool {
        availableSpaces > 0
    }
    var fetchedDate: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: fetchedAt)
    }
}

// MARK: - Area Style
extension ParkingLotInfo {
    var areaStyle: AreaStyle {
        return .init(rawValue: area) ?? .none
    }
}
