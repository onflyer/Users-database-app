//
//  SettingsView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/30/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage ("isDarkMode") private var isDark = false
    
    
    var body: some View {
        NavigationStack {
            Form() {
                Toggle("Dark Mode", isOn: $isDark)
            }
            .environment(\.colorScheme, isDark ? .dark : .light)
            .navigationTitle("Settings")
            
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
