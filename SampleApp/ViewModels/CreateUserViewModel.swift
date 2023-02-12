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
    @Published private(set) var error:FormError?
    @Published var hasError = false
    
    private let validator = CreateValidator()
    
    @MainActor
    func create() async {
        do {
            try validator.validate(user)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            
            print(user)
            
            try await NetworkingManager.shared.request(.createUser(submissionData: data))
            
            state = .successfull
            
        } catch  {
            self.hasError = true
            state = .unsuccessfull
            
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
            default:
                self.error = .system(error: error)
            }
        }
        
    }
}

extension CreateUserViewModel {
    enum SubmissionState {
        case unsuccessfull
        case successfull
        case submitting
    }
}

extension CreateUserViewModel {
    enum FormError:LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        case system(error: Error)
    }
    
}

extension CreateUserViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
             .validation(let err):
            return err.errorDescription
        case .system(let err):
            return err.localizedDescription 
        }
    }
}

