//
//  NetworkController.swift
//  Sprint12
//
//  Created by Sergey Osipyan on 3/8/19.
//  Copyright © 2019 Sergey Osipyan. All rights reserved.
//

import Foundation


private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=1&limit=500")!

class PokemonController: NSObject {
    
    
     @objc static let shared = PokemonController()
    
    
    
    @objc func fetchAllPokemon(completion: @escaping ([OSIPokemon]?, Error?) -> Void) {
        
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
                let pokemon = pokemonDictionaries.compactMap {OSIPokemon(dictionary: $0)}
                completion(pokemon, nil)
            } catch {
                completion(nil, error)
                return
            }
            }.resume()
    }
    
    
    @objc func fillInDetails(for pokemon: OSIPokemon) {
        
        let datatask = URLSession.shared.dataTask(with: pokemon.url!) { (data, _, error) in
            if let error = error {
                NSLog("Error filling in details for pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned...")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
               // pokemon.fillIn(with: json)
                
            } catch {
                NSLog("Error decoding Pokemon detail: \(error)")
            }
        }
        
        datatask.resume()
    }
}
