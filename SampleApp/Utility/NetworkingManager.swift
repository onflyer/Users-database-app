//
//  NetworkingManager.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/27/22.
//


import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    
    func request<T: Codable>(_ endpoint: EndPoint,
                             type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
        return res
        
        
    }
    
    
    func request(_ endpoint: EndPoint) async throws {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
            
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            print(statusCode)
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
            
        }
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidUrl
        case custom(error : Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    var errorDescription: String? {
        switch self {
        case .invalidUrl :
            return "URL isnt valid"
        case .invalidStatusCode:
            return "Status code fails in the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let error):
            return "Something went wrong \(error.localizedDescription)"
            
        }
    }
}



private extension NetworkingManager {
    func buildRequest(from url: URL,
                      methodType:EndPoint.MethodType) -> URLRequest {
        
        let myRestValue = "63a704ab6f2b84b6b5c9786a"
        let myApplicationID = "app-id"
        var request = URLRequest(url: url)
        request.setValue(myRestValue, forHTTPHeaderField: myApplicationID)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(myRestValue, forHTTPHeaderField: "X-Parse-REST-API-Key")
//        request.addValue(myApplicationID, forHTTPHeaderField: "X-Parse-Application-Id")
        print(url)
//
        
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data   
            
        }
        return request
    }
}
