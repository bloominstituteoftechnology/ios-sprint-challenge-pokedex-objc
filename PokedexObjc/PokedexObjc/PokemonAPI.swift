//
//  PokemonAPI.swift
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([TXCPokemon]?, Error?) -> Void) {
    
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String : Any]]
                    else {
                        throw NSError()
                }
                let pokemons = pokemonDictionaries.map { TXCPokemon(dictionary: $0) }
                completion(pokemons, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    
    
    @objc func fillInDetails(for pokemon: TXCPokemon) {
        
    }
    
    
    
    
    
}
