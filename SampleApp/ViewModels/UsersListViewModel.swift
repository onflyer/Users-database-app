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
    @Published private(set) var viewState:ViewState?  // replaced isLoading
    @Published var hasError = false
    
    private var page = 0 //for infinite scrolling
    private var totalPages:Int? // if we reach limit for total number of pages to not make a new request
    private var limit = 10
    private var pageLimit: Int?
    
    var isLoading:Bool {  // computed property for UsersListView isLoading
        viewState == .loading
    }
    
    var isFetching:Bool { // computed property for UsersListView isFetching
        viewState == .fetching
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        
        do {
            let response = try await NetworkingManager.shared.request(.usersList(page: page, limit: limit), type: UsersList.self)
            self.totalPages = response.total //set total pages limit from model
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
    func fetchNextSetOfUsers() async {  //for infinite scroll to fetch next page
        
        guard page != totalPages else {return}   // we dont fetch next set if we reach limit of pages
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        do {
            let response = try await NetworkingManager.shared.request(.usersList(page: page, limit: limit), type: UsersList.self)
            self.totalPages = response.total //set total pages limit from model
            self.users += response.data  // append new data onto the users Array from next page
        } catch  {
            self.hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
        
    }
    
    func hasReachedEnd(of user:User) -> Bool { // for infinite scrolling to se last user in array
        users.last?.id == user.id
    }
}

extension UsersListViewModel { // alows us to track a state of this viewmodel
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}

private extension UsersListViewModel { // for reseting state , page number and users Array like they were originaly
    func reset() {
        if viewState == .finished {
            users.removeAll()
            page = 1
            totalPages = nil
            viewState = nil
        }
    }

}
