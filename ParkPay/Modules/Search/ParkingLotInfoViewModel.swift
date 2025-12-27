//
//  ParkingLotInfoViewModel.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import Foundation

@MainActor
class ParkingLotInfoViewModel: ObservableObject {

    @Published var parkingLotInfo: ParkingLotInfo?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let apiService: APIService
    private let parkID: String

    init(parkID: String, apiService: APIService = .shared) {
        self.parkID = parkID
        self.apiService = apiService
    }

    func fetchParkingLotInfo() async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await apiService.fetchParkingLotInfo(parkID: parkID)
            parkingLotInfo = response.data
        } catch {
            errorMessage = error.localizedDescription
            print("Failed to fetch parking lot info: \(error)")
        }

        isLoading = false
    }
}
