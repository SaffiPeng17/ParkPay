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

    @State private var selected: HomeTab = .home
    @State private var showToast = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Tab content
            switch selected {
            case .home:
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
                    message: locationService.authStatus
                )

            case .search:
                SearchView()
                    .ignoresSafeArea()
            }

            // Tab
            PillTabView(selected: $selected)
                .padding(.bottom, 18)
        }
    }
}

#Preview {
    HomeView()
}
