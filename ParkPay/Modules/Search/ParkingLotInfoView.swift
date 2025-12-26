//
//  ParkingLotInfoView.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import SwiftUI

struct ParkingLotInfoView: View {
    let parkingLot: ParkingLot

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
                    HStack(spacing: 8) {
                        TagView(area: parkingLot.area,
                                areaStyle: parkingLot.areaStyle,
                                hasOutline: false)

                        Text(parkingLot.name)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                    // LeftCount, TotalCount
                    HStack(spacing: 30) {
                        parkingSpacesItem(title: "剩餘車位", count: 2, highlight: true)
                        parkingSpacesItem(title: "總共車位", count: parkingLot.totalCar)
                    }
                    // Details
                    VStack(alignment: .center, spacing: 10) {
                        infoItem(icon: "location", content: parkingLot.address)
                        infoItem(icon: "phone", content: parkingLot.tel)
                        infoItem(icon: "clock", content: "24H")
                        priceItem(content: "小型車：計時 30元/時(08-20)，20元/時(20-08)，展覽期間小型車60元/時(9-17)，停車全程以半小時計；月租 全日4，800元，日間4，000元(08-20)，夜間1，500元(週一至週五19-08，週六、日及政府行政機關放假之紀念日、民俗節日之全日)，大型重機2，400元/月。機車：20元/次，隔日另計；月租300元/月。")
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
    ParkingLotInfoView(parkingLot: .init(parkID: "1",
                                         area: "南港區",
                                         name: "世貿公園地下停車場",
                                         address: "台北市南港區", tel: "02-21315235",
                                         totalCar: 600,
                                         totalMotor: 0,
                                         totalBike: 0,
                                         totalBus: 0))
}
