//
//  ToastView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/14.
//

import SwiftUI

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.8))
            )
            .transition(.opacity.combined(with: .move(edge: .bottom)))
    }
}

#Preview {
    ToastView(message: "Toast")
}
