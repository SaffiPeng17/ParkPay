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
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // update map data here
    }
}
