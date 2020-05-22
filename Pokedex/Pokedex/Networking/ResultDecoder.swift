//
//  ResultDecoder.swift
//  Albums
//
//  Created by Shawn Gee on 4/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

protocol ResultDecoder {
    
    associatedtype ResultType
    
    var transform: (Data) throws -> ResultType { get }
    
    func decode(_ result: DataResult) -> Result<ResultType, NetworkError>
}

extension ResultDecoder {
    func decode(_ result: DataResult) -> Result<ResultType, NetworkError> {
        result.flatMap { data -> Result<ResultType, NetworkError> in
            Result { try transform(data) }
                .mapError { NetworkError.decodingError($0) }
        }
    }
}

struct PokemonResultDecoder: ResultDecoder {
    typealias ResultType = [Pokemon]

    var transform: (Data) throws -> ResultType = { data in
        guard let dict = try JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? Dictionary<AnyHashable, Any> else {
                throw NetworkError.decodingError(NSError(domain: "Error decoding pokemon", code: 0))
        }

        guard let results = dict["results"] as? Array<Dictionary<String, String>> else {
            throw NetworkError.decodingError(NSError(domain: "Error decoding pokemon", code: 0))
        }
        
        let pokemon = results.map { Pokemon(name: $0["name"]!)}

        return pokemon
    }
}

struct ImageResultDecoder: ResultDecoder {
    typealias ResultType = UIImage
    
    var transform: (Data) throws -> UIImage = { data in
        guard let image = UIImage(data: data) else {
            throw NetworkError.badData
        }
        
        return image
    }
}
