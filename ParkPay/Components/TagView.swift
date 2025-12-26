//
//  TagView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import SwiftUI

struct TagView: View {
    let area: String
    let areaStyle: AreaStyle
    let hasOutline: Bool

    var body: some View {
        Text(area)
            .font(.system(size: 11))
            .foregroundStyle(areaStyle.titleColor)
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background {
                RoundedRectangle(cornerRadius: 4)
                    .fill(areaStyle.backgroundColor)
            }
            .overlay {
                if hasOutline {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black.opacity(0.8), lineWidth: 1)
                }
            }
    }
}

#Preview {
    TagView(area: "南港區",
            areaStyle: .none,
            hasOutline: true)
}
