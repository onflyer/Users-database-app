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
        
        guard let url = endpoint.url else { // create url
            throw NetworkingError.invalidUrl  // if it fails we call our completion and show error
            // you need to call return because you need to stop execution after calling completion
        }
        
        var request = buildRequest(from: url, methodType: endpoint.methodType) // create request for url
        request.setValue("63a704ab6f2b84b6b5c9786a", forHTTPHeaderField: "app-id")//app id and token
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,    // handle response
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode)
        }
        let decoder = JSONDecoder()                // decode data
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        
        return res
        
        
    }
    
    
    func request(_ endpoint: EndPoint) async throws {
        
        guard let url = endpoint.url else { // create url
            throw NetworkingError.invalidUrl  // if it fails we call our completion and show error
            // you need to call return because you need to stop execution after calling completion
        }
        
        var request = buildRequest(from: url, methodType: endpoint.methodType)
        
        request.setValue("63a704ab6f2b84b6b5c9786a", forHTTPHeaderField: "app-id") //app id and token
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,    // handle response
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
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

extension NetworkingManager.NetworkingError {  //override error with our own error text
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
        
        var request = URLRequest(url: url) // create request for url
        request.setValue("63a704ab6f2b84b6b5c9786a", forHTTPHeaderField: "app-id")
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data   // link the data to send with our request to requestBody
        }
        return request
    }
}
