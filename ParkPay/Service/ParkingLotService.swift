//
//  ParkingLotService.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/26.
//

import Foundation

class ParkingLotService {
    static let shared = ParkingLotService()

    private init() {}

    func loadParkingLots() -> [ParkingLot] {
        guard let url = Bundle.main.url(forResource: "mock-parking-lots", withExtension: "json") else {
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(ParkingLotResponse.self, from: data)
            return response.data
        } catch {
            return []
        }
    }

    func searchParkingLots(query: String, in parkingLots: [ParkingLot]) -> [ParkingLot] {
        guard !query.isEmpty else {
            return []
        }

        return parkingLots.filter { parkingLot in
            parkingLot.name.localizedCaseInsensitiveContains(query) ||
            parkingLot.area.localizedCaseInsensitiveContains(query) ||
            parkingLot.address.localizedCaseInsensitiveContains(query)
        }
    }
}
