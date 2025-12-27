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

                if let parkingLotInfo = viewModel.parkingLotInfo {
                    // Content
                    VStack(alignment: .center, spacing: 18) {
                        // Title
                        HStack(spacing: 8) {
                            TagView(area: parkingLotInfo.area,
                                    areaStyle: parkingLotInfo.areaStyle,
                                    hasOutline: false)

                            Text(parkingLotInfo.name)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                        }
                        // LeftCount, TotalCount
                        HStack(spacing: 30) {
                            parkingSpacesItem(title: "剩餘車位",
                                              count: parkingLotInfo.realtime.availableSpaces,
                                              style: parkingLotInfo.areaStyle,
                                              highlight: true)
                            parkingSpacesItem(title: "總共車位",
                                              count: parkingLotInfo.realtime.totalSpaces,
                                              style: parkingLotInfo.areaStyle)
                        }
                        // Details
                        VStack(alignment: .center, spacing: 10) {
                            infoItem(icon: "location",
                                     content: parkingLotInfo.address,
                                     style: parkingLotInfo.areaStyle)
                            infoItem(icon: "phone",
                                     content: parkingLotInfo.tel,
                                     style: parkingLotInfo.areaStyle)
                            infoItem(icon: "clock",
                                     content: parkingLotInfo.serviceTime,
                                     style: parkingLotInfo.areaStyle)
                            priceItem(content: parkingLotInfo.payex)
                        }
                    }
                    .padding(18)
                } else {
                    if viewModel.isLoading {
                        // Loading state
                        VStack(spacing: 16) {
                            ProgressView()
                                .foregroundStyle(.gray)
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
            .frame(width: 320)
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
        .toast(
            isPresented: $showToast,
            message: viewModel.errorMessage ?? "發生錯誤"
        )
    }

    @ViewBuilder
    private func parkingSpacesItem(title: String, count: Int, style: AreaStyle, highlight: Bool = false) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(style.titleColor)
                .padding(.top, 10)
                .padding(.horizontal, 14)

            Text("\(count)")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(highlight ? Color(hex: "E76871") : .black)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                )
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
    private func infoItem(icon: String, content: String, style: AreaStyle) -> some View {
        HStack(spacing: 2) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundStyle(style.backgroundColor)
            }

            Text(content)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.black)
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
