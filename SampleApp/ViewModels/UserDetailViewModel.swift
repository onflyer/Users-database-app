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
    
    func fetchUserDetail(for id: String) {  // for id:string is to use string interpolation for url to add id for each user so when we click on user we can access his userdetailmodel
        isLoading = true
        NetworkingManager.shared.request(.userDetail1(id: id), type: UserDetailModel.self) { [weak self] res in
            
            DispatchQueue.main.async {
                defer { self?.isLoading = false }
                switch res {
                case.success(let response):
                    self?.userDetail = response  // there is no response.data because there is not data property in UserDetailModel , it is in UsersList, so we just asign it directly to response
                case.failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
