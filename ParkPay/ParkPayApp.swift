//
//  ParkPayApp.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/7.
//

import SwiftUI

@main
struct ParkPayApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
