//
//  ResultsDecoder.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

protocol ResultDecoder {
    associatedtype ResultType
    
    var transform: (Data) throws -> ResultType { get }
    func decode(_ result: DataResult) -> Result<ResultType, NetworkingError>
}
extension ResultDecoder {
    func decode(_ result: DataResult) -> Result<ResultType, NetworkingError> {
        result.flatMap { data -> Result<ResultType, NetworkingError> in
            Result { try transform(data) }
                .mapError { NetworkingError.decodingError($0) }
        }
    }
}

struct PokemonResultDecoder: ResultDecoder {
    typealias ResultType = [SBAPokemon]

    var transform: (Data) throws -> ResultType = { data in
        guard let dict = try JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? Dictionary<AnyHashable, Any> else {
                throw NetworkingError.decodingError(NSError(domain: "Error decoding pokemon", code: 0))
        }

        guard let results = dict["results"] as? Array<Dictionary<String, String>> else {
            throw NetworkingError.decodingError(NSError(domain: "Error decoding pokemon", code: 0))
        }
        
        let pokemon = results.map { SBAPokemon(name: $0["name"]!)}
        return pokemon
    }
}

struct ImageResultDecoder: ResultDecoder {
    typealias ResultType = UIImage
    
    var transform: (Data) throws -> UIImage = { data in
        guard let image = UIImage(data: data) else {
            throw NetworkingError.badData
        }
        return image
    }
}
