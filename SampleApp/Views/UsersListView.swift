//
//  UsersListView.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import SwiftUI
import Firebase

struct UsersListView: View {
    
    //sssss
    
    @AppStorage ("isDarkMode") private var isDark = false
    
    private var column = Array(repeating: GridItem(.flexible()), count: 1)
    
    @StateObject private var vm = UsersListViewModel()
    
    
    @State private var shouldShowCreate = false
    @State private var shouldShowSuccess = false
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundColor
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    
                    ScrollView {
                        LazyVGrid(columns: column, alignment: .center, spacing: 16) {
                            ForEach(vm.users, id:\.id) { user in
                                NavigationLink {
                                    UserDetailView(userId: user.id )
                                } label: {
                                    OneUserGridView(user: user)
                                        .task {
                                            if vm.hasReachedEnd(of: user) && !vm.isFetching {
                                                await vm.fetchNextSetOfUsers()
                                            }
                                        }
                                }
                                
                            }
                        }
                    }
                    .refreshable {
                        await vm.fetchUsers()
                    }
                    .overlay(alignment: .bottom) {
                        if vm.isFetching {
                            ProgressView()
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
            .task {
                if !hasAppeared {
                    await vm.fetchUsers()
                    hasAppeared = true
                }
                
                
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateUserView {
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .preferredColorScheme(isDark ? .dark : .light)
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchUsers()
                    }
                    
                }
            }
            .overlay {
                if shouldShowSuccess {
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
            shouldShowCreate.toggle()
            Analytics.logEvent("Add user", parameters: nil)
            
        } label: {
            Text("Add user")
                .font(.system(.headline, design: .rounded)
                    .bold())
            
        }
        
        .disabled(vm.isLoading)  
    }
}
