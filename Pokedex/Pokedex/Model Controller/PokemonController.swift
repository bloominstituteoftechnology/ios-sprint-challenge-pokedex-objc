//
//  PokemonController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 10/12/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import Foundation

class PokemonController: NSObject {
    
    @objc(sharedController) static let shared: PokemonController = PokemonController()
    
    @objc var pokemons: [LTBPokemon] = []
    
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([LTBPokemon]?, Error?) -> Void) {
//        let url = PokemonController.baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: PokemonController.baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving pokemons from server: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NSError())
                }
                return
            }
            
            do {
                guard let results = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    DispatchQueue.main.async {
                        completion(nil, NSError())
                    }
                    return
                }
                
                guard let pokemonDictionaries = results["results"] as? NSArray else {
                    DispatchQueue.main.async {
                        completion(nil, NSError())
                    }
                    return;
                }
                
                var allPokemon = [LTBPokemon]()
                
                for pokemonDictionary in pokemonDictionaries {
                    guard let pokemonDictionary = pokemonDictionary as? [AnyHashable : Any] else { continue }
                    let pokemon = LTBPokemon(dictionary: pokemonDictionary)
                    allPokemon.append(pokemon)
                }
                
                DispatchQueue.main.async {
                    self.pokemons = allPokemon
                    completion(allPokemon, nil)
                }
            } catch {
                NSLog("Unable to encode name: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: LTBPokemon) {
        let url = PokemonController.baseURL.appendingPathComponent(pokemon.name)//.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error retrieving pokemon info from server: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                guard let pokemonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any] else { return }
                
                DispatchQueue.main.async {
                    pokemon.update(with: pokemonDict)
                }
            } catch {
                NSLog("Unable to encode name: \(error)")
            }
            return
        }.resume()
    }
}
