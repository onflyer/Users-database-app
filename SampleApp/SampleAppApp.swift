//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/24/22.
//

import SwiftUI

@main
struct SampleAppApp: App {
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
