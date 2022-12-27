//
//  UsersListView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import SwiftUI

struct UsersListView: View {
    
    private var column = Array(repeating: GridItem(.flexible()), count: 1)
    
    @State private var users:[User] = []
    
    @State private var shouldShowCreate = false //for showing sheet to create
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                ScrollView {
                    LazyVGrid(columns: column, alignment: .center, spacing: 16) {
                        ForEach(users, id:\.id) { item in
                            NavigationLink {
                                UserDetailView()
                            } label: {
                                OneUserGridView(user: item) // sad prikazuje samo prvog ispravicemo
                            }

                            
                            
                            
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
            .onAppear {
                do {
                    let res = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersList.self) //znaci mozes odmah dekodirati glavni model koji sadrzi sve modele i cita ga bey problema (UserList a u njemu [User]
                    users = res.data
                } catch {
                        print(error)
                        
                    }
                }
            .sheet(isPresented: $shouldShowCreate) {
                CreateUserView()
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
            shouldShowCreate.toggle() // for sheet
        } label: {
            Text("Add user")
                .font(.system(.headline, design: .rounded)
                    .bold())
                
        }
    }
}
