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
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func create() {
        state = .submitting
        let encoder = JSONEncoder()
        let data = try? encoder.encode(user)
        
        NetworkingManager.shared.request(methodType: .POST(data: data), "https://dummyapi.io/data/v1/user/create?app-id=63a704ab6f2b84b6b5c9786a") { [weak self] res in
           
            DispatchQueue.main.async {
               
                switch res {
                    
                case .success:
                    self?.state = .successfull
                case .failure(let err):
                    self?.state = .unsuccessfull
                    self?.hasError = true
                    self?.error = err as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}

extension CreateUserViewModel {  // we can comunicate back to the view if its success or not for submit
    enum SubmissionState {
        case unsuccessfull
        case successfull
        case submitting // for progresview 
    }
}
