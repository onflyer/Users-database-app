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
    
    var queryItems: [String: String]? {  // this is for PAGE AND LIMIT PARAMETERS, optional because you sometimes dont need query items
        switch self {
        case .usersList(let page, let limit):
            return ["page": "\(page)", "limit": "\(limit)"]  //query items
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
            URLQueryItem(name: item.key, value: item.value)  // in this case item.key is "page" and item value is \(page)
        }
        
#if DEBUG
        requestQueryItems?.append(URLQueryItem(name: "", value: "")) // WHEN YOU WANT TO ADD FOR EXAMPLE delay=2
#endif
        
        urlComponents.queryItems = requestQueryItems // this is for urlcomponents to use our dictionary for parameters var requestQueryItems
        return urlComponents.url  // returnt url from components
    }
}

