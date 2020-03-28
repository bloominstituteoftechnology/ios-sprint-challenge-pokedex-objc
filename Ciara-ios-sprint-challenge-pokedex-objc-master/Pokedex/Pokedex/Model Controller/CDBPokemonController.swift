//
//  CDBPokemonController.swift
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class CDBPokemonController: NSObject {
    
    @objc(sharedController) static let shared = CDBPokemonController()
        
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        
    // MARK: Get all pokemons
    @objc func fetchPokemons(completion: @escaping ([CDBPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let results = jsonDictionary["results"] as? [[String : Any]] else { throw NSError() }
                
                let pokemon = results.compactMap { CDBPokemon(dictionary: $0) }
                completion(pokemon, nil)
                
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    // MARK: Get pokemon details
    @objc func fetchPokemonDetails(with pokemon: CDBPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data,
                error == nil else { return }
            
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw NSError()
                }
                pokemon.values(fromDict: jsonDictionary)
                                
                // TODO: get sprite image
                if let spriteURL = pokemon.sprite?.imageURL {
                    URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
                        guard error == nil else { return }
                        guard let data = data, let image = UIImage(data: data) else { return }
                        
                        pokemon.sprite?.image = image
                        
                    }.resume()
                }
                
            } catch {
                NSLog("Error filling in details for \(pokemon): \(error)")
                return
            }
        }.resume()
    }
}
