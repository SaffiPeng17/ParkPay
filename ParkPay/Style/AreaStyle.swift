//
//  AreaStyle.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/27.
//

import SwiftUICore

enum AreaStyle: String {
    case none 
    case shiLin = "士林區"
    case daTong = "大同區"
    case daan = "大安區"
    case zhongShan = "中山區"
    case zhongZheng = "中正區"
    case neiHu = "內湖區"
    case wenshan = "文山區"
    case beiTou = "北投區"
    case songShan = "松山區"
    case xinYi = "信義區"
    case nanGang = "南港區"
    case wanHua = "萬華區"
    case neiHuTech = "內科專區"

    var backgroundColor: Color {
        switch self {
        case .shiLin:     return .init(hex: "#010701")
        case .daTong:     return .init(hex: "#388E3C")
        case .daan:       return .init(hex: "#4828A8")
        case .zhongShan:  return .init(hex: "#B34CA3")
        case .zhongZheng: return .init(hex: "#4B74B3")

        case .neiHu:      return .init(hex: "#B37A4B")
        case .wenshan:    return .init(hex: "#E07B53")
        case .beiTou:     return .init(hex: "#8ED483")
        case .songShan:   return .init(hex: "#D49E81")
        case .xinYi:      return .init(hex: "#B0799F")

        case .nanGang:    return .init(hex: "#427BC2")
        case .wanHua:     return .init(hex: "#5DC4C4")
        case .neiHuTech:  return .init(hex: "#D6D65D")

        case .none: return .init(hex: "#4A4A45")
        }
    }

    var titleColor: Color {
        switch self {
        case .shiLin:     return .init(hex: "#BCBCBC")
        case .daTong:     return .init(hex: "#DFFED5")
        case .daan:       return .init(hex: "#BFB7DA")
        case .zhongShan:  return .init(hex: "#F9DBFD")
        case .zhongZheng: return .init(hex: "#E4F6FE")

        case .neiHu:      return .init(hex: "#FFFFF1")
        case .wenshan:    return .init(hex: "#71371F")
        case .beiTou:     return .init(hex: "#416735")
        case .songShan:   return .init(hex: "#654D3C")
        case .xinYi:      return .init(hex: "#FFFFFF")

        case .nanGang:    return .init(hex: "#E8FEFF")
        case .wanHua:     return .init(hex: "#2F5F5F")
        case .neiHuTech:  return .init(hex: "#63661D")

        case .none: return .init(hex: "#BCBCBC")
        }
    }
}
