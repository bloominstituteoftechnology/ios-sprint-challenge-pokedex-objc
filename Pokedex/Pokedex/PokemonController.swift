//
//  PokemonController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 4/12/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation
import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!


class PokemonController: NSObject {
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([GLIPokemon]?, Error?) -> Void) {
        
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
                
                let pokemon = pokemonDictionaries.compactMap { GLIPokemon(dictionary: $0) }
                
                completion(pokemon, nil)
                
            } catch {
                return completion(nil, error)
            }
        }.resume()
        
    }
    

    
    @objc func fillInDetails(for pokemon: GLIPokemon) {
        
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        
        var detailURL = baseURL.appendingPathComponent(pokemon.name)
        
        
        
        
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
                
                let pokemon = pokemonDictionaries.compactMap { GLIPokemon(dictionary: $0) }
                
                completion(pokemon, nil)
                
            } catch {
                return completion(nil, error)
          }
        }.resume()

    }
    
    
}
