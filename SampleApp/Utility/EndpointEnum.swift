//
//  EndpointEnum.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/30/22.
//

import Foundation

//MARK: NE KORISTIM OVO UOPSTE U APP ALI MOZE SE UVESTI

enum EndPoint {
    case usersList
    case userDetail1(id: String)
    case createUser(submissionData: Data?)
}

extension EndPoint {
    enum MethodType {
        case GET
        case POST(data: Data?) //associated value to send some kind of data and make it an optional if you dont want send anything through
    }
}

extension EndPoint {
    
    var host: String {"dummyapi.io"}
    
    var path: String {
        switch self {
        case .usersList:
            return "/data/v1/user"
        case .userDetail1 (let id):
            return "/data/v1/user/\(id)"
        case .createUser:
            return "/data/v1/user/create"
        }
    }
    var methodType:MethodType {
        switch self {
        case .usersList:
            return .GET
        case .userDetail1:  // no need for let id its just for this is .get request
            return .GET
        case .createUser(let data):
            return .POST(data: data)
        }
    }
    
//    var queryItems: [String: String]? {  // optional because you sometimes dont need query items
//        switch self {
//        case .usersList(let page):
//            return ["page": "\(page)"]
//        default:
//            return nil
//        }
//    }
}

extension EndPoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"  // http or https
        urlComponents.host = host
        urlComponents.path = path
//        urlComponents.queryItems = [
//        URLQueryItem(name: <#T##String#>, value: <#T##String?#>)
//        ]
        
//        var requestQueryItems = queryItems?.compactMap { item in   // compactMap helps us fill nil values as well
//            URLQueryItem(name: item.key, value: item.value)
//        }
        
        return urlComponents.url  // returnt url from components
    }
}

