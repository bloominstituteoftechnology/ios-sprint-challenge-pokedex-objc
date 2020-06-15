//
//  PokemonAPI.swift
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case URLError
    case UnableToCompleteFetch
    case InvalidResponse
    case DataNilError
    case BadDataError
    case JSONDecodeError
    case JSONMissingResults
}

@objc(DTWPokemonAPI)
class PokemonAPI: NSObject {
    
    private let baseURLString = "https://pokeapi.co/api/v2/pokemon/"
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc(fetchAllPokemonWithCompletionHandler:)
    func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(string: baseURLString)
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "999"),
                                     URLQueryItem(name: "offset", value: "0")]
        
        guard let url = urlComponents?.url else {
            completion(nil, APIError.URLError)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, APIError.DataNilError)
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw APIError.JSONDecodeError
                }
                
                guard let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                    throw APIError.JSONMissingResults
                }
                
                let pokemonArray = pokemonDictionaries.compactMap { Pokemon(dictionary: $0) }
                
                DispatchQueue.main.async {
                    completion(pokemonArray, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    @objc(fillInDetailsForPokemon:)
    func fillInDetails(for pokemon: Pokemon) {
        
        URLSession.shared.dataTask(with: pokemon.detailsURL!) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error fetching pokemon details: \(error)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("Error fetching pokemon details: \(APIError.DataNilError)")
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw APIError.JSONDecodeError
                }
                
                guard let pokemonDetails = PokemonDetail(dictionary: dictionary) else {
                    throw APIError.JSONMissingResults
                }
                
                DispatchQueue.main.async {
                    pokemon.details = pokemonDetails
                    self.fetchImage(for: pokemon, using: pokemonDetails.spriteURL!)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error decoding pokemon details: \(error)")
                }
            }
        }.resume()
    }
    
    private func fetchImage(for pokemon: Pokemon, using url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error fetching pokemon image: \(error)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    print("Error fetching pokemon image: \(APIError.DataNilError)")
                }
                return
            }
            
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    print("Error decoding pokemon image: \(APIError.BadDataError)")
                }
                return
            }
            
            DispatchQueue.main.async {
                pokemon.sprite = image
            }
        }.resume()
    }
}
