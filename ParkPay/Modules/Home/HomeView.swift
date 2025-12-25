//
//  ContentView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/7.
//

import SwiftUI
import CoreLocation

struct HomeView: View {
    @StateObject private var locationService = LocationService()
    @State private var showToast = false

    var body: some View {
        ZStack {
            GoogleMapView(
                center: CLLocationCoordinate2D(latitude: 25.04385, longitude: 121.56064),
                zoom: 16
            )
            .ignoresSafeArea()
            .onAppear {
                locationService.requestPermission()

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showToast = true
                    }
                }
            }
            .toast(
                isPresented: $showToast,
                message: statusText(locationService.authorizationStatus)
            )
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
    HomeView()
}
