//
//  SeedlingApp.swift
//  Seedling
//
//  Created by Wai Shuen Wu on 11/16/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct SeedlingApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
