//
//  GoogleMapView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/14.
//

import SwiftUI
import GoogleMaps

struct GoogleMapView: UIViewRepresentable {
    let center: CLLocationCoordinate2D
    let zoom: Float
    
    func makeCoordinator() -> Coordinator { Coordinator() }

    final class Coordinator {
        var marker: GMSMarker?
    }

    func makeUIView(context: Context) -> GMSMapView {
        let options = GMSMapViewOptions()
        options.camera = GMSCameraPosition(latitude: center.latitude,
                                           longitude: center.longitude,
                                           zoom: zoom)
        let mapView = GMSMapView(options: options)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        let markerView = GMSMarker(position: center)
        markerView.iconView = makeMarkerView(MarkerView(title: "Stone"))
        // Align the bottom of the marker to the coordinate point
        markerView.groundAnchor = .init(x: 0.5, y: 1.0)
        markerView.appearAnimation = .pop

        // Create marker view -> UIView
        Task { @MainActor in
            markerView.map = mapView
        }

        context.coordinator.marker = markerView
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // update map data here

        context.coordinator.marker?.position = center
    }
}
