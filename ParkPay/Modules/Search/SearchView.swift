//
//  SearchView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @FocusState private var isSearchBarFocused: Bool

    @State private var searchText = ""
    @State private var showParkingLotInfo = false
    @State private var selectedParkingLot: ParkingLot? = nil
    @State private var showToast = false

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
                        viewModel.clearResults()
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
            } else if viewModel.isLoading {
                Spacer().frame(height: 100)
                VStack(spacing: 12) {
                    ProgressView()
                        .tint(.gray)
                    Text("Searching...")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else if viewModel.parkingLots.isEmpty && !viewModel.isLoading {
                Spacer().frame(height: 100)
                VStack(spacing: 12) {
                    Image(systemName: "exclamationmark.magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("No results found")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(viewModel.parkingLots) { parkingLot in
                            resultItem(parkingLot: parkingLot,
                                       isSelected: selectedParkingLot?.id == parkingLot.id)
                            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                            .onTapGesture {
                                selectedParkingLot = parkingLot

                                isSearchBarFocused = false // dismiss Keyboard
                                showParkingLotInfo = true // show ParkingLotInfo
                            }
                            .onAppear {
                                guard viewModel.shouldLoadNextPage(currentItem: parkingLot) else { return }
                                Task {
                                    await viewModel.loadNextPage()
                                }
                            }
                        }

                        // Loading more indicator
                        if viewModel.isLoadingMore {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .padding(.vertical, 20)
                                    .tint(.gray)
                                Spacer()
                            }
                        }

                        Spacer(minLength: 120)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 24)
                }
                .simultaneousGesture( // monitor drag gestures to reset TextField focus
                    DragGesture().onChanged { _ in
                        if isSearchBarFocused {
                            isSearchBarFocused = false
                        }
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
        .fullScreenCover(isPresented: $showParkingLotInfo) {
            if let parkingLot = selectedParkingLot {
                let viewModel = ParkingLotInfoViewModel(parkID: parkingLot.parkID)
                ParkingLotInfoView(viewModel: viewModel)
            }
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .onChange(of: showParkingLotInfo) { oldValue, newValue in
            if !newValue {
                selectedParkingLot = nil
            }
        }
        .onChange(of: searchText) { oldValue, newValue in
            Task {
                await viewModel.fetchParkingLots(keyword: newValue)
            }
        }
        .onChange(of: viewModel.errorMessage) { oldValue, newValue in
            if newValue != nil {
                showToast = true
            }
        }
        .onTapGesture {
            isSearchBarFocused = false
        }
        .toast(
            isPresented: $showToast,
            message: viewModel.errorMessage ?? "發生錯誤"
        )
    }

    @ViewBuilder
    private func resultItem(parkingLot: ParkingLot, isSelected: Bool) -> some View {
        HStack(alignment: .top, spacing: 8) {
            VStack(spacing: 6) {
                TagView(area: parkingLot.area,
                        areaStyle: parkingLot.areaStyle,
                        hasOutline: false)

                HStack(alignment: .center, spacing: 2) {
                    if parkingLot.totalCar > 0 {
                        vehicleTypeView(icon: "car.fill")
                    }
                    if parkingLot.totalMotor > 0 {
                        vehicleTypeView(icon: "motorcycle.fill")
                    }
                    if parkingLot.totalBike > 0 {
                        vehicleTypeView(icon: "bicycle")
                    }
                    if parkingLot.totalBus > 0 {
                        vehicleTypeView(icon: "bus.fill")
                    }
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(parkingLot.name)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black)

                Text(parkingLot.address)
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

    @ViewBuilder
    private func vehicleTypeView(icon: String) -> some View {
        Image(systemName: icon)
            .font(.system(size: 10))
            .foregroundStyle(.blue)
    }
}

#Preview {
    SearchView()
}
