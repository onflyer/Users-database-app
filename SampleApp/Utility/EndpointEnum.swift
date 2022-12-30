//
//  EndpointEnum.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/30/22.
//

import Foundation

//MARK: NE KORISTIM OVO UOPSTE U APP ALI MOZE SE UVESTI

enum EndPoint {
    case usersList (page:Int)
    case userDetail(id: String)
    case createUser(submissionData: Data?)
}

extension EndPoint {
    enum MethodType {
        case GET
        case POST(data: Data?) //associated value to send some kind of data and make it an optional if you dont want send anything through
    }
}

extension EndPoint {
    
    var host: String {"https://dummyapi.io/data/v1/"}
    
    var path: String {
        switch self {
        case .usersList:
            return "user"
        case .userDetail (let id):
            return "user\(id)"
        case .createUser:
            return "user/create"
        }
    }
    var methodType:MethodType {
        switch self {
        case .usersList:
            return .GET
        case .userDetail:  // no need for let id:
            return .GET
        case .createUser(let data):
            return .POST(data: data)
        }
    }
    
    var queryItems: [String: String]? {  // optional because you sometimes dont need query items
        switch self {
        case .usersList(let page):
            return ["page": "\(page)"]
        default:
            return nil
        }
    }
}

extension EndPoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"  // http or https
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = queryItems?.compactMap { item in   // compactMap helps us fill nil values as well
            URLQueryItem(name: item.key, value: item.value)
        }
        
        return urlComponents.url  // returnt url from components
    }
}

