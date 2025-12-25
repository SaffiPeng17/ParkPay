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
    @State private var isKeyboardVisible = false

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
            if !isKeyboardVisible {
                PillTabView(selected: $selected)
                    .padding(.bottom, 18)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            setupKeyboardNotifications()
        }
        .onDisappear {
            removeKeyboardNotifications()
        }
    }

    // MARK: - Keyboard Notifications
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { _ in
            withAnimation(.easeOut(duration: 0.3)) {
                isKeyboardVisible = true
            }
        }

        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillHideNotification,
            object: nil,
            queue: .main
        ) { _ in
            withAnimation(.easeOut(duration: 0.3)) {
                isKeyboardVisible = false
            }
        }
    }

    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

#Preview {
    HomeView()
}
