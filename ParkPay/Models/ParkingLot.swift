//
//  ParkingLot.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/26.
//

import Foundation

struct ParkingLotResponse: Codable {
    let success: Bool
    let data: [ParkingLot]
    let pagination: Pagination
}

struct ParkingLot: Codable, Identifiable {
    let parkID: String
    let area: String
    let name: String
    let address: String
    let tel: String
    let totalCar: Int
    let totalMotor: Int
    let totalBike: Int
    let totalBus: Int

    var id: String { parkID }

    enum CodingKeys: String, CodingKey {
        case parkID = "park_id"
        case area
        case name
        case address
        case tel
        case totalCar = "total_car"
        case totalMotor = "total_motor"
        case totalBike = "total_bike"
        case totalBus = "total_bus"
    }
}

struct Pagination: Codable {
    let page: Int
    let limit: Int
    let total: Int
    let totalPages: Int
}

// MARK: - Style
extension ParkingLot {
    var areaStyle: AreaStyle {
        return .init(rawValue: area) ?? .none
    }
}
