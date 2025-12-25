//
//  MarkerView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/16.
//

import SwiftUI

struct MarkerView: View {
    @State var title: String = "Park"

    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.red)
                .frame(height: 14)

            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 20, weight: .semibold))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.red, .white)
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    MarkerView()
}
