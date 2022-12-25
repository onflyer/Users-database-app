//
//  StaticJSONMapper.swift
//  SampleApp
//
//  Created by Aleksandar Milidrag on 12/25/22.
//

import Foundation


struct StaticJSONMapper {
    static func decode<T:Decodable>(file:String,type:T.Type) throws -> T { // we are going to apply generic constraint of decodable onto this function, we want to tell this function to pass in the type to tell it how you want to map it to model you desire and retur that model to us
        
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContent
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
                
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContent
    }
    
}
