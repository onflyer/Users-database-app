//
//  UserDetailViewModel.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import Foundation


final class UserDetailViewModel:ObservableObject {
    
    @Published private (set) var userDetail:UserDetailModel?  //(set) can be modified just inside of this class and not outside
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published private(set) var isLoading:Bool = false
    @Published var hasError = false
    
    @MainActor
    func fetchUserDetail(for id: String) async {  // for     isLoading = true
        defer { isLoading = false }
        
        do {
        self.userDetail = try await NetworkingManager.shared.request(.userDetail1(id: id), type: UserDetailModel.self)
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
