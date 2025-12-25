//
//  HomeTabType.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/25.
//

import Foundation

enum HomeTab: String, CaseIterable {
    case home
    case search

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .search: return "magnifyingglass"
        }
    }

    var title: String {
        self.rawValue
    }
}
