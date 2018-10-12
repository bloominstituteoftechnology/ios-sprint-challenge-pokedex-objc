//
//  PokemonController.swift
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

@objc(SMFPokemonController)
class PokemonController : NSObject {
    
    @objc(sharedController) static let shared = PokemonController()
    
    private static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([SMFPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: PokemonController.baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let results = dictionary["results"] as? [[String: String]] else {
                    
                        NSLog("JSON was not a dictionary")
                    completion(nil, NSError())
                    return
                }
                
                var pokemons: [SMFPokemon] = []
                for pokemonDict in results {
                    let pokemon = SMFPokemon(dictionary: pokemonDict)
                    pokemons.append(pokemon)
                }
                completion(pokemons, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: SMFPokemon) {
        
    }
}
