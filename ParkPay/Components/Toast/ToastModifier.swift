//
//  ToastModifier.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/14.
//

import SwiftUI

// Toast view show/hide control
struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: Double

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: message)
                    Spacer()
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}
