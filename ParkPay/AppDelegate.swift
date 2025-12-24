//
//  AppDelegate.swift
//  ParkPay
//
//  Created by Saffi Peng on 2025/12/14.
//

import UIKit

// Perform initial setup after app launch
final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        AppInitService().initialServices()
        return true
    }
}
