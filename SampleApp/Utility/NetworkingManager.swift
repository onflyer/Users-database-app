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
    
    func request<T: Codable>(_ absoluteURL: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        
        guard let url = URL(string: absoluteURL) else { // create url
            completion(.failure(NetworkingError.invalidUrl))  // if it fails we call our completion and show error
            return  // you need to call return because you need to stop execution after calling completion
        }
        let request = URLRequest(url: url) // create request for url
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in //create dataTask to execute request , dont forget to call resume
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            guard let response = response as? HTTPURLResponse,    // handle response
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {  // unwrap data
                completion(.failure(NetworkingError.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()                // decode data
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
            
        }
        dataTask.resume()
        
    }
}


extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidUrl
        case custom(error : Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
