//
//  PokemonController.swift
//  Pokedex-objc
//
//  Created by Simon Elhoej Steinmejer on 10/12/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "http://pokeapi.co/api/v2/pokemon/")!

class PokemonController: NSObject {
    
    
    @objc static let shared = PokemonController()
    
    
    @objc func fetchAllPokemon(completion: @escaping ([VUKPokemon]?, Error?) -> Void) {
        
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                completion(nil,error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try (JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String: Any]] else {
                    completion(nil, NSError())
                    return
                }
                let pokemon = pokemonDictionaries.compactMap {VUKPokemon(dictionary: $0)}
                completion(pokemon, nil)
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: VUKPokemon) {
        let url = pokemon.url
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error filling in details \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data")
                return
            }
            
            do {
                guard let dictionary = try (JSONSerialization.jsonObject(with: data, options: [])) as? [String : Any] else {return}
                pokemon.fillInDetails(with: dictionary)
            } catch {
                return
            }
        }.resume()
    }
}

