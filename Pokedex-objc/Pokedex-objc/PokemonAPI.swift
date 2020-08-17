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
    case noDictionary
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
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
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            guard error == nil else {
                print("Error creating DataTask")
                completion(nil, NetworkError.otherError)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw NetworkError.noDictionary
                }
                
                guard let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                    throw NetworkError.noDecode
                }
                
                let pokemon = pokemonDictionaries.compactMap{ MKMPokemon(dictionary: $0) }
                DispatchQueue.main.async {
                    completion(pokemon, nil)
                }
            } catch {
                completion(nil, NetworkError.noDecode)
                return
            }
            
        }
        dataTask.resume()
    }
}
