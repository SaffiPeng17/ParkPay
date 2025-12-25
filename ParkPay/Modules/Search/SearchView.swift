//
//  SearchView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 20) {

            // MARK: - Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("", text: $searchText,
                          prompt: Text("Search parking spots...") // placeholder
                                    .foregroundColor(.gray.opacity(0.3)))
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.black)
                    .focused($isFocused)

                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .frame(height: 36)
            .padding(.vertical, 6)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal, 24)
            .padding(.top, 84)

            // MARK: - Search Results
            if searchText.isEmpty { // empty results
                Spacer().frame(height: 100)
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("Search for parking spots")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(0..<5) { index in
                            resultItem(area: "南港區", title: "世貿公園地下停車場 \(index + 1)", address: "台北市南港區東興路1124號")
                        }
                        .padding(.horizontal, 24)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .onTapGesture {
            isFocused = false
        }
    }

    @ViewBuilder
    private func resultItem(area: String, title: String, address: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(area)
                .font(.system(size: 12))
                .foregroundStyle(.white)
                .padding(.all, 2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.brown)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)

                Text(address)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }

            Spacer()
        }
        .padding(.all, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    SearchView()
}
