//
//  SampleAppApp.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/24/22.
//

import SwiftUI

@main
struct SampleAppApp: App {
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
            
        }
    }
}
