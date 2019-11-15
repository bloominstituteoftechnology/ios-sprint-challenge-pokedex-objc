//
//  CDBPokemonController.swift
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

@objc class CDBPokemonController: NSObject {
    
    @objc var pokemons: [CDBPokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    // MARK: Get all pokemons
    
    @objc func fetchPokemons(completion: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error: Data task fetching error")
                completion(error)
                return
            }
            
            guard let data = data else {
                NSLog("Error: No data from data task")
                completion(error)
                return
            }
            
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let resultsDict = jsonDict["results"] as? [[String: String]] {
                        for pokemon in resultsDict {
                            let eachPokemon = CDBPokemon(dictionary: pokemon)
                            self.pokemons.append(eachPokemon)
                        }
                    }
                }
            } catch {
                NSLog("Error: No pokemon data")
                completion(error)
            }
        }.resume()
    }
    
    // MARK: Get pokemon details


    
    
}
