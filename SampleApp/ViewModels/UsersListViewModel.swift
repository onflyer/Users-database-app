//
//  UsersListViewModel.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import Foundation

final class UsersListViewModel: ObservableObject {
    
    @Published private (set) var users:[User] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading:Bool = false
    @Published var hasError = false
    
    
    @MainActor
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let response = try await NetworkingManager.shared.request(.usersList, type: UsersList.self)
            self.users = response.data
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
            
        
    }
}
