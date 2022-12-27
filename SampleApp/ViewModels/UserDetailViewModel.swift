//
//  UserDetailViewModel.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//

import Foundation


final class UserDetailViewModel:ObservableObject {
    
    @Published private (set) var userDetail:UserDetailModel?  //(set) can be modified just inside of this class and not outside
    
    func fetchUserDetail(for id: String) {  // for id:string is to use string interpolation for url to add id for each user so when we click on user we can access his userdetailmodel
        NetworkingManager.shared.request("https://dummyapi.io/data/v1/user/\(id)", type: UserDetailModel.self) { [weak self] res in
            
            DispatchQueue.main.async {
                switch res {
                case.success(let response):
                    self?.userDetail = response  // there is no response.data because there is not data property in UserDetailModel , it is in UsersList, so we just asign it directly to response
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
}
