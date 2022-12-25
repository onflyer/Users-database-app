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
                Color(.secondarySystemBackground)
                    .edgesIgnoringSafeArea(.top)
                ScrollView {
                    LazyVGrid(columns: column, alignment: .center, spacing: 16) {
                        ForEach(0...5, id:\.self) { item in
                            HStack {
                                VStack(alignment: .trailing) {
                                    Image(systemName: "person")
                                        .resizable()
                                        .padding()
                                    
                                }
                                .frame(width: 150, height: 150)
                                Divider()
                                Spacer()
                                VStack(alignment: .leading) {
                                    Text("INFO")
                                    Text("INFO")
                                    Text("INFO")
                                    Text("INFO")
                                }
                                .frame(width: 200, height: 150, alignment: .leading)
                                
                            
                                    
                            }
                            .frame(width: 360, height: 230)
                            .background(Color.gray)
                            .cornerRadius(20)
                            
                            
                        }
                    }
                }
            }
            .navigationTitle("People")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        
                    } label: {
                        Text("Add user")
                            .font(.system(.headline, design: .rounded)
                                .bold())
                            
                    }

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
