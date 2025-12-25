//
//  LocationService.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/8.
//

import UIKit
import Foundation
import CoreLocation

final class LocationService: NSObject, ObservableObject {
    private let manager = CLLocationManager()

    // Output
    @Published private(set) var authStatus: String = ""

    // Properties
    private var authorizationStatus: CLAuthorizationStatus = .notDetermined {
        didSet {
            authStatus = statusText(authorizationStatus)
        }
    }
    private var location: CLLocation?

    // Initial
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = manager.authorizationStatus
        authStatus = statusText(authorizationStatus)
    }
}

// MARK: - Public Methods
extension LocationService {
    func requestPermission() {
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            startUpdateLocation()
        }
    }
}

// MARK: - 🔒 Private Methods
private extension LocationService {
    func startUpdateLocation() {
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        default:
            manager.stopUpdatingLocation()
        }
    }

    // Go to Settings to allow location sharing
    func openAppSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }

    func statusText(_ status: CLAuthorizationStatus) -> String {
        switch status {
        case .notDetermined: return "Not Determined"
        case .restricted: return "Restricted"
        case .denied: return "Denied" // Can be modified in Settings
        case .authorizedWhenInUse: return "Authorized: WhenInUse"
        case .authorizedAlways: return "Authorized: Always"
        @unknown default: return "Unknown"
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        startUpdateLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        // Get location once on app launch
        manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error)
    }
}
