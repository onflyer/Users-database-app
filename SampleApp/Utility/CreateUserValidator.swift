//
//  CreateUserValidator.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/30/22.
//

import Foundation

struct CreateValidator{
    func validate(_ user:CreateUser) throws {
        if user.firstName.isEmpty {
            throw CreateValidatorError.invalidLastName
            
        }
        if user.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
            
        }
        if user.email.isEmpty {
            throw CreateValidatorError.invalidEmail
            
        }
    }
}


extension CreateValidator {
    enum CreateValidatorError:LocalizedError {
        case invalidFirstName
        case invalidLastName
        case invalidEmail
    }
}

extension CreateValidator.CreateValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidFirstName:
            return "First name cant be empty"
        case .invalidLastName:
            return "Last name cant be empty"
        case .invalidEmail:
            return "Email cant be empty"
        }
    }
}


