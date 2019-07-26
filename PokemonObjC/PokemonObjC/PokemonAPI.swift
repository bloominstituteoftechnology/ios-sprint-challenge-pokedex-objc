//
//  PokemonAPI.swift
//  PokemonObjC
//
//  Created by Ryan Murphy on 7/26/19.
//  Copyright © 2019 Ryan Murphy. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

class PokemonAPI : NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([CCCPokemon]?, Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let limitQuery = URLQueryItem(name: "limit", value: "75")
        components.queryItems = [limitQuery]
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                return completion(nil, error)
            }
            
            guard let data = data else {
                return completion(nil, NSError())
            }
            
            do {
        
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    
                let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                        throw NSError()
                }
                
                let allPokemon = pokemonDictionaries.compactMap { CCCPokemon(dictionary: $0) }
                
                completion(allPokemon, nil)
                
            } catch {
                return completion(nil, error)
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: CCCPokemon) {
        
        let requestURL = baseURL.appendingPathComponent(pokemon.name.lowercased())
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data PokAPI ln:64")
                return
            }
            
            do {
                
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    throw NSError()
                }
             
                let caughtPokemon = CCCPokemon.init(dictionary: dictionary)
                
                pokemon.name = caughtPokemon.name
                pokemon.abilities = caughtPokemon.abilities
                pokemon.sprite = caughtPokemon.sprite
                
                pokemon.pokemonID = caughtPokemon.pokemonID
                
            } catch {
                NSLog("Error")
            }
        }.resume()
    }
}
