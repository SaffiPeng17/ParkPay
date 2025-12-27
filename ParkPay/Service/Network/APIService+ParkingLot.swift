//
//  APIService+ParkingLot.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

extension APIService {
    // Get parking lots
    func fetchParkingLots(request: ParkingLotsRequest) async throws -> ParkingLotsResponse {
        try await self.request(target: APITarget.parkingLots(request: request))
    }

    // Get a parking lot info with realtime spaces
    func fetchParkingLotInfo(parkID: String) async throws -> ParkingLotInfoResponse {
        try await self.request(target: APITarget.parkingLotInfo(parkID: parkID))
    }
}
