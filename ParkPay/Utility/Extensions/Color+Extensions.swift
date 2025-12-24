//
//  Color+Extensions.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/15.
//

import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1.0) {
        var hexString = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .uppercased()

        if hexString.hasPrefix("#") {
            hexString.removeFirst()
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0

        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
