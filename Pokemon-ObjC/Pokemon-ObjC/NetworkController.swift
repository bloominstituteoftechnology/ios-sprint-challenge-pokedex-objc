//
//  NetworkController.swift
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared: PokemonAPI
    
    @objc func fetchAllPokemon(completion: @escaping ([JTMPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("error with dataTask: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data returned from GET")
                completion(nil, error)
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let pokemonDictionary = dictionary["results"] as? [String: Any] else {
                        completion(nil, NSError())
                        return
                        
                }
                let pokemon = pokemonDictionary.compactMap{ JTMPokemon(dictionary: $0) }
            } catch {
                
            }
        }
        
    }
    
    @objc func fillInDetails(for pokemon: JTMPokemon) {
        
    }
    
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemon: [JTMPokemon] = []
}
