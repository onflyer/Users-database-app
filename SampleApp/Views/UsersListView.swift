//
//  UsersListView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import SwiftUI

struct UsersListView: View {
    
    private var column = Array(repeating: GridItem(.flexible()), count: 1)
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                ScrollView {
                    LazyVGrid(columns: column, alignment: .center, spacing: 16) {
                        ForEach(0...5, id:\.self) { item in
                            OneUserGridView(user: item)
                            
                            
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    addUser

                }
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}

private extension UsersListView {
    var backgroundColor:some View {
        Color(.secondarySystemBackground)
            .edgesIgnoringSafeArea(.top)
    }
    var addUser:some View {
        Button {
            
        } label: {
            Text("Add user")
                .font(.system(.headline, design: .rounded)
                    .bold())
                
        }
    }
}
