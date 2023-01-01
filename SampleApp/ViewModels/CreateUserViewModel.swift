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
    @Published private(set) var error:FormError? // NetworkingManager.NetworkingError? replaced with formerror enum
    @Published var hasError = false
    
    private let validator = CreateValidator() // instance of validator
    
    func create() {
        
        do {
            try validator.validate(user)
            
            state = .submitting
            let encoder = JSONEncoder()
            let data = try? encoder.encode(user)
            
            NetworkingManager.shared.request(.createUser(submissionData: data)) { [weak self] res in
               
                DispatchQueue.main.async {
                   
                    switch res {
                        
                    case .success:
                        self?.state = .successfull
                    case .failure(let err):
                        self?.state = .unsuccessfull
                        self?.hasError = true
                        if let networkingError = err as? NetworkingManager.NetworkingError { // safe way to unwrap form error
                            self?.error = .networking(error: networkingError)
                        }
                        
                    }
                }
            }
        } catch  {
            self.hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = .validation(error: validationError)
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

extension CreateUserViewModel {   // combining with networking error
    enum FormError:LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
    }
    
}

extension CreateUserViewModel.FormError { // extracting error desrcription from associated value from the cas
    var errorDescription: String? {
        switch self {
        case .networking(let err),
             .validation(let err):
            return err.errorDescription
        }
    }
}

