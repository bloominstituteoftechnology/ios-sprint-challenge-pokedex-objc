//
//  PokemonAPI.swift
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/5/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

@objc (MJRPokemonAPI)
class PokemonAPI: NSObject {
    
    @objc (sharedController) static let shared = PokemonAPI()
    
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
                
                let pokemon = Pokemon(dictionary: pokemonDictionary)
                
                self.pokemon = pokemon
                
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Properties
    
    // private(set) var pokedex: [Pokemon] = []
    private(set) var pokemon: Pokemon?
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
}
