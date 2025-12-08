//
//  ContentView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/7.
//

import SwiftUI
import MapKit        // 顯示地圖、座標、Region、Annotation

struct ContentView: View {
    @EnvironmentObject var locationService: LocationService

    @State private var position: MapCameraPosition = .region(.init())

    var body: some View {
        Map(position: $position) {
            UserAnnotation()
        }
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            locationService.requestLocation()
        }
        .onChange(of: locationService.lastLocation) { oldValue, newValue in
            guard oldValue != newValue, let location = newValue else {
                return
            }
            position = .region(
                MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
    }
}

#Preview {
    ContentView()
}
