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
    @State private var shouldShowSuccess = false // for checkmark popover
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                
                if vm.isLoading {
                    ProgressView()
                }else {
                    
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
                CreateUserView{  // closure for checkmark
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchUsers()
                }
            } // ok button default for alert
            .overlay {
                if shouldShowSuccess { // showing and hiding overlay checkmark
                    CheckMarkPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
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
        .disabled(vm.isLoading)  // so you cant click add user when is loading is true
    }
}
