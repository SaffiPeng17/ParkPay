//
//  LocationService.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/8.
//

import Foundation
import MapKit
import CoreLocation

final class LocationService: NSObject, ObservableObject {

    // MARK: - Properties
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastLocation: CLLocation?
    @Published var region: MKCoordinateRegion

    private let manager = CLLocationManager()

    // MARK: - Init
    override init() {
        self.authorizationStatus = manager.authorizationStatus

        // 預設 region (先放台北)
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 25.0330, longitude: 121.5654),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

        super.init()

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    /// 要求權限 & 開始更新位置
    func requestLocation() {
        // 如果還沒決定過，先請求「使用期間」權限
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways {
            manager.startUpdatingLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus

        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            manager.stopUpdatingLocation()
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        print(locations)

        guard let location = locations.last, location != lastLocation else { return }
        lastLocation = location

        // 使用 DispatchQueue.main.async 避免在 view update 期間修改狀態
        DispatchQueue.main.async { [weak self] in
            self?.region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error:", error.localizedDescription)
    }
}
