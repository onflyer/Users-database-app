//
//  EndpointEnum.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/30/22.
//

import Foundation

// UVEDENO NA CIJELI APP

enum EndPoint {
    case usersList(page: Int,limit:Int)
    case userDetail1(id: String)
    case createUser(submissionData: Data?)
}

extension EndPoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
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
        case .userDetail1:
            return .GET
        case .createUser(let data):
            return .POST(data: data)
        }
    }
    
    var queryItems: [String: Any]? {
        switch self {
        case .usersList(let page, let limit):
            return ["page": "\(page)", "limit": "\(limit)"]
        default:
            return nil
        }
    }
}

extension EndPoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        
        var requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: (item.value as! String))
        }
        

        requestQueryItems?.append(URLQueryItem(name: "" , value: ""))

        
        urlComponents.queryItems = requestQueryItems
        return urlComponents.url  
    }
    
}

