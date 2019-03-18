//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

import Foundation

@objc
class PokemonAPI: NSObject {
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc
    func fetchAllPokemon(completion: @escaping([JDBPokemon]?, Error?) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: PokemonAPI.baseURL) {data, _, error in
            
            if let error = error {
                NSLog("Error fetching pokemon data: \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let pokemonResults = results["results"] as? [[String: Any]]
                
                let resultsArray = pokemonResults?.compactMap{ JDBPokemon(dictionary: $0) }
                completion(resultsArray, nil)
                
            } catch {
                NSLog("Error fetching pokemon data: \(String(describing: error))")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
    @objc
    func fillInDetails(for pokemon: JDBPokemon) {
        
        let urlString = pokemon.url;
        print("urlString\(urlString)")
        let pokemonURL = URL(string: urlString)!
        
        let dataTask = URLSession.shared.dataTask(with: pokemonURL) {data, _, error in
            
            if let error = error {
                NSLog("Error fetching pokemon data: \(String(describing: error))")
                return
            }
            
            guard let data = data else {
                return
            }
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let selectedPokemon = JDBPokemon.init(dictionary: results)
                print("selectedPokemon\(String(describing: selectedPokemon))")
                print("pokemon\(String(describing: pokemon))")
                
                pokemon.name = selectedPokemon.name
                pokemon.idNumber = selectedPokemon.idNumber
                pokemon.abilities = selectedPokemon.abilities
                pokemon.sprite = selectedPokemon.sprite
                
            } catch {
                
            }
        }
        dataTask.resume()
    }
}
