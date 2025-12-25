//
//  SearchView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Text("Search")
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    SearchView()
}
