//
//  SearchView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct SearchView: View {
    @FocusState private var isSearchBarFocused: Bool

    @State private var searchText = ""
    @State private var showParkingLotInfo = false
    @State private var selectedIndex: Int? = nil
    @State private var selectedTitle: String? = nil

    var body: some View {
        VStack {
            // MARK: - Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField("", text: $searchText,
                          prompt: Text("Search parking spots...") // placeholder
                                    .foregroundColor(.gray.opacity(0.3)))
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.black)
                    .focused($isSearchBarFocused)

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
                            let title = "世貿公園地下停車場 \(index + 1)"
                            resultItem(area: "南港區", title: title, address: "經貿二路88巷1號地下", isSelected: selectedIndex == index)
                                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                                .onTapGesture {
                                    selectedIndex = index // update selectedIndex
                                    selectedTitle = title

                                    isSearchBarFocused = false // dismiss Keyboard
                                    showParkingLotInfo = true // show ParkingLotInfo
                                }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .fullScreenCover(isPresented: $showParkingLotInfo) {
            ParkingLotInfoView(title: selectedTitle ?? "", leftCount: 346, totalCount: 400, address: "經貿二路88巷1號地下", phone: "(02)28817033", time: "24H", price: "小型車：計時 30元/時(08-20)，20元/時(20-08)，展覽期間小型車60元/時(9-17)，停車全程以半小時計；月租 全日4，800元，日間4，000元(08-20)，夜間1，500元(週一至週五19-08，週六、日及政府行政機關放假之紀念日、民俗節日之全日)，大型重機2，400元/月。機車：20元/次，隔日另計；月租300元/月。")
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .onChange(of: showParkingLotInfo) { oldValue, newValue in
            if !newValue {
                selectedIndex = nil
                selectedTitle = nil
            }
        }
        .onTapGesture {
            isSearchBarFocused = false
        }
    }

    @ViewBuilder
    private func resultItem(area: String, title: String, address: String, isSelected: Bool) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text(area)
                .font(.system(size: 12))
                .foregroundStyle(.black)
                .padding(.all, 2)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.brown.opacity(0.5))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.black.opacity(0.8), lineWidth: 1)
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
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .black.opacity(0.8) : .gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    SearchView()
}
