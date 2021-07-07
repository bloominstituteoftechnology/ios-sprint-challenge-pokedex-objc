//
//  PokemonAPI.swift
//  PokedexObjC
//
//  Created by Daniela Parra on 11/30/18.
//  Copyright © 2018 Daniela Parra. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([DYPPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String: Any]] else { throw NSError() }
                
                let pokemon = pokemonDictionaries.compactMap{ pokemon in
                    autoreleasepool { () -> DYPPokemon in
                        DYPPokemon(dictionary: pokemon)
                    }
                }
                
                completion(pokemon, nil)
                
            } catch {
                return completion(nil, error)
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: DYPPokemon) {
        
        let requestURL = baseURL.appendingPathComponent(pokemon.name)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task.")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let scratchPokemon = DYPPokemon(dictionary: dictionary) else { throw NSError() }
                
                if pokemon != scratchPokemon {
                    pokemon.abilities = scratchPokemon.abilities
                    pokemon.identifier = scratchPokemon.identifier
                    pokemon.sprite = scratchPokemon.sprite
                }
                
            } catch {
                NSLog("Error decoding pokemon.")
            }
        }.resume()
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
}
