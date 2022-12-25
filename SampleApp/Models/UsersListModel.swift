//
//  UsersListModel.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/24/22.
//

import Foundation

// MARK: - UsersList
struct UsersList: Codable {
    let data: [User]
    let total, page, limit: Int
}

// MARK: - User
struct User: Codable {
    let id: String
    let title: Title
    let firstName, lastName: String
    let picture: String
}

enum Title: String, Codable {
    case miss = "miss"
    case mr = "mr"
    case mrs = "mrs"
    case ms = "ms"
}
