//
//  PokemonController.swift
//  Pokedex
//
//  Created by Lambda_School_Loaner_34 on 4/12/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

@objc (PokemonController)
class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("error getting data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                guard let results = dictionary["results"] as? [[String: Any]] else { throw NSError() }
                
                let pokedex = results.map({ Pokemon(dictionary: $0) })
                completion(pokedex, nil)
                
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return completion(nil, NSError())
            }
        }
        dataTask.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("error getting data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            
            do {
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                
                let updatedPokemon = Pokemon(dictionary: pokemonDictionary)
                pokemon.name = updatedPokemon.name
                pokemon.abilities = updatedPokemon.abilities
                pokemon.identifier = updatedPokemon.identifier
                pokemon.sprite = updatedPokemon.sprite
                
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return
            }
        }
        dataTask.resume()
    }
    
}
