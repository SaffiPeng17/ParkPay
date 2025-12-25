//
//  ParkingLotInfoView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct ParkingLotInfoView: View {
    let title: String
    let leftCount: Int
    let totalCount: Int
    let address: String
    let phone: String
    let time: String
    let price: String

    @Environment(\.dismiss) private var dismiss
    
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.2)
                .onTapGesture {
                    dismiss()
                }

            // Info
            ZStack {
                Color.white.cornerRadius(20)

                VStack(alignment: .center, spacing: 18) {
                    // Title
                    HStack(spacing: 10) {
                        Image(systemName: "parkingsign.square.fill")
                            .font(.system(size: 18))
                            .foregroundStyle(.blue)

                        Text(title)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                    // LeftCount, TotalCount
                    HStack(spacing: 30) {
                        parkingSpacesItem(title: "剩餘車位", count: leftCount, highlight: true)
                        parkingSpacesItem(title: "總共車位", count: totalCount)
                    }
                    // Details
                    VStack(alignment: .center, spacing: 10) {
                        infoItem(icon: "location", content: address)
                        infoItem(icon: "phone", content: phone)
                        infoItem(icon: "clock", content: time)
                        priceItem(content: price)
                    }
                }
                .padding(18)
            }
            .frame(maxWidth: 340)
            .scaleEffect(scale)
            .opacity(opacity)
            .fixedSize()
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                    scale = 1.0
                    opacity = 1.0
                }
            }
        }
        .ignoresSafeArea()
        .presentationBackground(.clear)
    }

    @ViewBuilder
    private func parkingSpacesItem(title: String, count: Int, highlight: Bool = false) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.black)
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
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "#F4CF53"))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray.opacity(0.4), lineWidth: 1)
        )
    }

    @ViewBuilder
    private func infoItem(icon: String, content: String) -> some View {
        HStack(spacing: 2) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(.system(size: 15))
                    .foregroundStyle(.blue)
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
    ParkingLotInfoView(title: "Parking 1",
                       leftCount: 10,
                       totalCount: 200,
                       address: "台北市南港區",
                       phone: "02-21315235",
                       time: "24H",
                       price: "計時：150元/時，停車未滿1小時以1小時計，逾1小時以上者，未滿半小時以半小時計。月租：10，000元/月。")
}
