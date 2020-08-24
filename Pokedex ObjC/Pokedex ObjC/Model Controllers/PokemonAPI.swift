//
//  PokemonAPI.swift
//  Pokedex ObjC
//
//  Created by Scott Bennett on 11/30/18.
//  Copyright © 2018 Scott Bennett. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([SLBPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                return completion(nil, error)
            }
            guard let data = data else {
                return completion(nil, NSError())
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                        throw NSError()
                }
                
                let pokemons = pokemonDictionaries.compactMap { SLBPokemon(dictionary: $0) }
                completion(pokemons, nil)
                
            } catch {
                return completion(nil, error)
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: SLBPokemon) {
        
    }

}
