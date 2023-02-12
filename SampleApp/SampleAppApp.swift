//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/24/22.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      

    return true
  }
}

@main
struct SampleAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @AppStorage ("isDarkMode") private var isDark = false
    var body: some Scene {
        WindowGroup {
            TabView {
                UsersListView()
                    .tabItem {
                        Image(systemName: "person.2")
                        Text("Home")
                    }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
            .environment(\.colorScheme, isDark ? .dark : .light)
        }
    }
}
