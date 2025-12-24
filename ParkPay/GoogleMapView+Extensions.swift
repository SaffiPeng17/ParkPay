//
//  GoogleMapView+Extensions.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/16.
//

import SwiftUI
import UIKit

extension GoogleMapView {
    func makeMarkerView<V: View>(_ view: V) -> UIView {
        let host = UIHostingController(rootView: view)
        host.view.backgroundColor = .clear

        let size = CGSize(width: 60, height: 80)
        host.view.bounds = .init(origin: .zero, size: size)

        return host.view
    }
}
