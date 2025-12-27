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
}
