//
//  UsersListView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import SwiftUI

struct UsersListView: View {
    
    private var column = Array(repeating: GridItem(.flexible()), count: 1)
    
    @StateObject private var vm = UsersListViewModel()
    
    
    @State private var shouldShowCreate = false //for showing sheet to create
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                ScrollView {
                    LazyVGrid(columns: column, alignment: .center, spacing: 16) {
                        ForEach(vm.users, id:\.id) { user in
                            NavigationLink {
                                UserDetailView(userId: user.id )  // pozovem id usera koji sam dobio iz foreach 
                            } label: {
                                OneUserGridView(user: user) // sad prikazuje samo prvog ispravicemo
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
                
                vm.fetchUsers()
               
                }
            .sheet(isPresented: $shouldShowCreate) {
                CreateUserView()
            }
            .alert(isPresented: $vm.hasError, error: vm.error) { } // ok button default for alert
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
