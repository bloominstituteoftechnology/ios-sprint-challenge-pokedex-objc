//
//  PokemonController.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

enum HTTPMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let delete = "DELETE"
}

enum NetworkingError: Error {
    case transportError(Error)
    case badData
    case noData
    case serverError(statusCode: Int)
    case decodingError(Error)
    case encodingError(Error)
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


private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

typealias PokemonResultsCompletion = (Result<[SBAPokemon], NetworkingError>) -> Void
typealias ImageResultCompletion = (Result<UIImage, NetworkingError>) -> Void


@objc class PokeApiClient: NSObject {
    @objc func fetchSortedPokemon(completion: @escaping ([SBAPokemon]?, Error?) -> Void) {
        self.fetchAllPokemon { (result) in
            switch result {
            case .failure(let error):
                completion(nil, NSError(domain: error.localizedDescription, code: 0))
            case .success(let pokemon):
                completion(pokemon.sorted(by: { $0.name < $1.name }), nil)
            }
    }
}


    func fetchAllPokemon(completion: @escaping PokemonResultsCompletion) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "500")
        ]
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            completion(PokemonResultDecoder().decode(result))
        }.resume()
    }
    
    
    
    
}
