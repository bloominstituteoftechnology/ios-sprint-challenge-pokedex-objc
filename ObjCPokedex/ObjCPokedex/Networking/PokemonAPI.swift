//
//  PokemonAPI.swift
//  ObjCPokedex
//
//  Created by Kobe McKee on 7/26/19.
//  Copyright © 2019 Kobe McKee. All rights reserved.
//

import Foundation


@objc (PokemonAPI)
class PokemonAPI: NSObject {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([KTMPokemon]?, Error?) -> Void) {
    
        let dataTask = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned when fetching all pokemon")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let pokemonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                guard let results = pokemonDict["results"] as? [[String: Any]] else { throw NSError() }
                
                let pokedex = results.map({ KTMPokemon(dictionary: $0) })
                completion(pokedex, nil)
                return
            } catch {
                NSLog("Error parsing all pokemon: \(error)")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
    
    
    @objc func fillInDetails(for pokemon: KTMPokemon) {
        
        let pokemonURL = baseURL.appendingPathComponent(pokemon.name)
        
        let dataTask = URLSession.shared.dataTask(with: pokemonURL) { (data, _, error) in
            if let error = error {
                NSLog("Error filling in pokemon details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned when fetching pokemon details")
                return
            }
            
            do {
                guard let pokemonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                
                let updatedPokemon = KTMPokemon(dictionary: pokemonDict)
                
                pokemon.name = updatedPokemon.name
                pokemon.identifier = updatedPokemon.identifier
                pokemon.abilities = updatedPokemon.abilities
                pokemon.spriteURL = updatedPokemon.spriteURL
                
                
            } catch {
                NSLog("Error trying to parse pokemon details")
                return
            }
        }
        dataTask.resume()     
    }
    
    
    
}




