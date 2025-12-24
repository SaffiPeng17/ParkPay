//
//  AppInitService.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/19.
//

import Foundation
import GoogleMaps

final class AppInitService {
    // Static flag to ensure services are only initialized once
    private static var hasInitialized = false

    // Initial
    init() {}
}

// MARK: - Public Methods
extension AppInitService {
    func initialServices() {
        // Prevent multiple initializations
        guard !AppInitService.hasInitialized else {
            return
        }

        AppInitService.hasInitialized = true
        initGoogleMap()
    }
}

// MARK: - 🔒 Google Map
private extension AppInitService {
    func initGoogleMap() {
        GMSServices.provideAPIKey("_")
    }
}
