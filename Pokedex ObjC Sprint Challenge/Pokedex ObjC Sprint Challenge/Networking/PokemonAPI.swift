//
//  PokemonAPI.swift
//  Pokedex ObjC Sprint Challenge
//
//  Created by Audrey Welch on 3/15/19.
//  Copyright © 2019 Audrey Welch. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

class PokemonAPI : NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([ALWPokemon]?, Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                return completion(nil, error)
            }
            
            guard let data = data else {
                return completion(nil, NSError())
            }
            
            do {
                
                // Take data and turn it into a JSON object (a dictionary)
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                
                    // Now we have a dictionary - the top level is Results: []
                    let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                        throw NSError()
                }
                
                print(pokemonDictionaries)
                
                // Turn array into Pokemon objects
                let allPokemon = pokemonDictionaries.compactMap { ALWPokemon(dictionary: $0) }
                
//                var allPokemon = [ALWPokemon]()
//                for dictionary in pokemonDictionaries {
//                    if let pokemon = ALWPokemon(dictionary: dictionary) {
//                        allPokemon.append(pokemon)
//                    }
//                }
                
                print(allPokemon)
            
                completion(allPokemon, nil)
                
            } catch {
                return completion(nil, error)
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: ALWPokemon) {
        
        let requestURL = baseURL.appendingPathComponent(pokemon.name.lowercased())
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            // unwrap the error if we have one
            if let error = error {
                NSLog("Error fetching search results: \(error)")
                return
            }
            
            // unwrap the data
            guard let data = data else {
                NSLog("Request didn't return valid data.")
                return
            }
            
            do {
                
                // Take data and turn it into a JSON object (a dictionary)
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    throw NSError()
                }
                
                    // Now we have a dictionary - the top le
                
            } catch {
                
            }
        }
        
        
    }
}
