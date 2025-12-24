//
//  ContentView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/7.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var locationService = LocationService()

    var body: some View {
        ZStack {
            GoogleMapView(
                center: CLLocationCoordinate2D(latitude: 25.0478, longitude: 121.5170),
                zoom: 14
            )
            .ignoresSafeArea()
            .onAppear {
                locationService.requestPermission()
            }

            Text(statusText(locationService.authorizationStatus))

        }
    }

    private func statusText(_ status: CLAuthorizationStatus) -> String {
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

#Preview {
    ContentView()
}
