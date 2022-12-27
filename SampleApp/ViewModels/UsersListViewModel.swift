//
//  UsersListViewModel.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import Foundation

final class UsersListViewModel: ObservableObject {
    
    @Published private (set) var users:[User] = []
    
    func fetchUsers() {
        NetworkingManager.shared.request("https://dummyapi.io/data/v1/user/", type: UsersList.self) { [weak self] res in
            
            DispatchQueue.main.async { 
                switch res {
                case.success(let response):
                    self?.users = response.data
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
}
