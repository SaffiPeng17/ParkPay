//
//  View+Extensions.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/14.
//

import SwiftUICore

extension View {
    func toast(isPresented: Binding<Bool>,
               message: String,
               duration: Double = 3.0) -> some View {
        self.modifier(
            ToastModifier(isPresented: isPresented,
                          message: message,
                          duration: duration)
        )
    }
}
