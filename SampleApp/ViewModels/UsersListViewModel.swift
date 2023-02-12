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
    @Published private(set) var viewState:ViewState?
    @Published var hasError = false
    
    private var page = 0
    private var totalPages:Int?
    private var limit = 10
    
    
    var isLoading:Bool {
        viewState == .loading
    }
    
    var isFetching:Bool {
        viewState == .fetching
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        
        do {
            let response = try await NetworkingManager.shared.request(.usersList(page: page, limit: limit), type: UsersList.self)
            self.totalPages = response.total
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
    
    @MainActor
    func fetchNextSetOfUsers() async {
        
        guard page != totalPages else {return}
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        do {
            let response = try await NetworkingManager.shared.request(.usersList(page: page, limit: limit), type: UsersList.self)
            self.totalPages = 8
            self.users += response.data
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    func hasReachedEnd(of user:User) -> Bool {
        users.last?.id == user.id
    }
}

extension UsersListViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension UsersListViewModel { 
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 0
            viewState = nil
        }
    }

}
