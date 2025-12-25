//
//  PillTabView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct PillTabView: View {
    @Binding var selected: HomeTab

    var body: some View {
        HStack(spacing: 15) {
            tabItem(.home)
            Spacer()
            tabItem(.search)
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.10), radius: 12, x: 0, y: 6)
        )
        .fixedSize()
    }

    // MARK: - 🔒 Private
    @ViewBuilder
    private func tabItem(_ tab: HomeTab) -> some View {
        let isSelected = (selected == tab)

        Button {
            selected = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.icon)
                    .font(.system(size: 18, weight: .semibold))
                Text(tab.rawValue)
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundStyle(isSelected ? .black : .gray.opacity(0.4))
            .fixedSize()
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var selected: HomeTab = .home
    PillTabView(selected: $selected)
}
