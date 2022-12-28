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
    
    func fetchUsers() {
        isLoading = true
        NetworkingManager.shared.request("https://dummyapi.io/data/v1/user/", type: UsersList.self) { [weak self] res in
            
            DispatchQueue.main.async {
                defer {
                    self?.isLoading = false
                }
                switch res {
                case.success(let response):
                    self?.users = response.data
                case.failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
