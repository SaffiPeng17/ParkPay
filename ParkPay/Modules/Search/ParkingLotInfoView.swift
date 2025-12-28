//
//  ParkingLotInfoView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct ParkingLotInfoView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: ParkingLotInfoViewModel

    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    @State private var showToast = false
    @State private var showCallConfirmation = false
    @State private var phoneNumber = ""

    init(viewModel: ParkingLotInfoViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.2)
                .onTapGesture {
                    dismiss()
                }

            // Info
            ZStack {
                Color.white.cornerRadius(20)

                if let info = viewModel.parkingLotInfo {
                    // Content
                    VStack(alignment: .center, spacing: 18) {
                        // Title
                        HStack(spacing: 8) {
                            TagView(area: info.area,
                                    areaStyle: info.areaStyle,
                                    hasOutline: false)

                            Text(info.name)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        // LeftCount, TotalCount
                        HStack(spacing: 30) {
                            parkingSpacesItem(title: "剩餘車位",
                                              count: info.realtime.availableSpaces,
                                              style: info.areaStyle,
                                              highlight: true)
                            parkingSpacesItem(title: "總共車位",
                                              count: info.realtime.totalSpaces,
                                              style: info.areaStyle)
                        }
                        //
                        HStack(spacing: 8) {
                            if info.totalCar > 0 {
                                spaceTypeItem(icon: "car.fill",
                                              count: info.totalCar)
                            }
                            if info.totalMotor > 0 {
                                spaceTypeItem(icon: "motorcycle.fill",
                                              count: info.totalMotor)
                            }
                            if info.totalBike > 0 {
                                spaceTypeItem(icon: "bicycle",
                                              count: info.totalBike)
                            }
                            if info.totalBus > 0 {
                                spaceTypeItem(icon: "bus.fill",
                                              count: info.totalBus)
                            }
                            if info.totalLargeMotor > 0 {
                                spaceTypeItem(icon: "motorcycle",
                                              count: info.totalLargeMotor)
                            }
                            if info.totalCharging > 0 {
                                spaceTypeItem(icon: "ev.charger.fill",
                                              count: info.totalCharging)
                            }
                            if info.totalPregnancy > 0 {
                                spaceTypeItem(icon: "figure.and.child.holdinghands",
                                              count: info.totalPregnancy)
                            }
                            if info.totalHandicap > 0 {
                                spaceTypeItem(icon: "figure.roll",
                                              count: info.totalHandicap)
                            }
                        }
                        // Details
                        VStack(alignment: .center, spacing: 10) {
                            infoItem(icon: "location",
                                     content: info.address,
                                     style: info.areaStyle)
                            infoItem(icon: "phone",
                                     content: info.tel,
                                     style: info.areaStyle)
                            infoItem(icon: "clock",
                                     content: info.serviceTime,
                                     style: info.areaStyle)
                            priceItem(content: info.payex)
                        }
                    }
                    .padding(18)
                } else {
                    if viewModel.isLoading {
                        // Loading state
                        VStack(spacing: 16) {
                            ProgressView()
                                .tint(.gray)
                                .scaleEffect(1.2)
                            Text("載入中...")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(.gray)
                        }
                        .padding(40)
                    } else {
                        Text("發生錯誤")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.gray)
                            .padding(40)
                    }
                }
            }
            .frame(width: 340)
            .scaleEffect(scale)
            .opacity(opacity)
            .fixedSize()
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    scale = 1.0
                    opacity = 1.0
                }
                Task {
                    await viewModel.fetchParkingLotInfo()
                }
            }
        }
        .ignoresSafeArea()
        .presentationBackground(.clear)
        .onChange(of: viewModel.errorMessage) { oldValue, newValue in
            if newValue != nil {
                showToast = true
            }
        }
        .toast(isPresented: $showToast,
               message: viewModel.errorMessage ?? "發生錯誤")
        .alert("確定要撥打停車場服務專線嗎？",
               isPresented: $showCallConfirmation) {
            Button("是") {
                if let url = URL(string: "tel://\(phoneNumber)") {
                    UIApplication.shared.open(url)
                }
            }
            Button("否", role: .cancel) {}
        }
    }

    @ViewBuilder
    private func parkingSpacesItem(title: String, count: Int, style: AreaStyle, highlight: Bool = false) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(style.titleColor)
                .padding(.top, 10)
                .padding(.horizontal, 14)

            Text(count < 0 ? "--" : "\(count)")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(highlight ? .blue : .black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 8)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                }
        }
        .frame(width: 90)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .fill(style.backgroundColor)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.4), lineWidth: 1)
        }
    }

    @ViewBuilder
    private func spaceTypeItem(icon: String, count: Int) -> some View {
        ZStack {
            HStack(spacing: 2) {
                Image(systemName: icon)
                    .font(.system(size: 12))

                Text("\(count)")
                    .font(.system(size: 12, weight: .medium))
            }
            .foregroundStyle(.black.opacity(0.7))
            .padding(.horizontal, 7)
            .padding(.vertical, 4)
        }
        .frame(height: 22)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.4), lineWidth: 1)
        }
    }

    @ViewBuilder
    private func infoItem(icon: String, content: String, style: AreaStyle) -> some View {
        HStack(spacing: 2) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundStyle(style.backgroundColor)
            }

            Text(content)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(icon == "phone" ? .blue : .black)
                .underline(icon == "phone")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if icon == "phone" {
                phoneNumber = content
                showCallConfirmation = true
            }
        }
    }

    @ViewBuilder
    private func priceItem(content: String) -> some View {
        Text(content)
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(.black.opacity(0.5))
    }
}

#Preview {
    ParkingLotInfoView(viewModel: .init(parkID: "1"))
}
