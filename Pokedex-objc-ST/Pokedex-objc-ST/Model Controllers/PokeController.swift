//
//  PokeController.swift
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation



class PokeController: NSObject {
    
    private let baseURL = URL(string:"https://pokeapi.co/api/v2/pokemon")!
    @objc var allPokemon = [JLCPokemon]()
    
    @objc func fetchAllPokemon(completion: @escaping ([JLCPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon:\(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let error = NSError()
                NSLog("Bad data. Error with data when fetching all pokemon:\(error)")
                completion(nil, error)
                return
            }
            
            do{
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let pokeDictionaries = jsonDictionary["results"] as? [[String : Any]] else {
                        throw NSError()
                }
                
                let pokemon = pokeDictionaries.compactMap { JLCPokemon(dictionary: $0) }
                self.allPokemon = pokemon
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding pokemon:\(error)")
                completion(nil, error)
            }
        }.resume()
    }

    //@objc fetchSinglePokemon(with ID: Int
    
}
