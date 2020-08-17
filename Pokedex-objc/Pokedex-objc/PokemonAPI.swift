//
//  PokemonAPI.swift
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case noIdentifier
    case otherError
    case noData
    case noDecode
    case noEncode
    case noRep
    case noURL
}

@objc (MKMPokemonAPI)
class PokemonAPI: NSObject {
    @objc(sharedController) static let shared = PokemonAPI()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(fetchAllPokemon:)
    func fetchAllPokemon(completion: @escaping ([MKMPokemon]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let limitItem = URLQueryItem(name: "limit", value: "1000")
        urlComponents?.queryItems = [limitItem]
        
        guard let requestURL = urlComponents?.url else {
            completion(nil, NetworkError.noURL)
            return
        }
        
        print(requestURL)
        
    }
}
