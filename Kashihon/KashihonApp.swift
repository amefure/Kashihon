//
//  KashihonApp.swift
//  Kashihon
//
//  Created by t&a on 2023/07/12.
//

import FirebaseCore
import GoogleMobileAds
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool
    {
        // Firebase
        FirebaseApp.configure()
        // Google AdMob
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }
}

@main
struct KashihonApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
