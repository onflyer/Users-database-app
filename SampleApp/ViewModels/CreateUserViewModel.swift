//
//  CreateUserViewModel.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/28/22.
//

import Foundation


final class CreateUserViewModel: ObservableObject {
    
    @Published var user = CreateUser()
    @Published private (set) var state: SubmissionState?
    
    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(user)
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://dummyapi.io/data/v1/user/create?app-id=63a704ab6f2b84b6b5c9786a") { [weak self] res in
           
            DispatchQueue.main.async {
               
                switch res {
                    
                case .success:
                    self?.state = .successfull
                case .failure(let err):
                    self?.state = .unsuccessfull
                }
            }
        }
    }
}

extension CreateUserViewModel {  // we can comunicate back to the view if its success or not for submit
    enum SubmissionState {
        case unsuccessfull
        case successfull
    }
}
