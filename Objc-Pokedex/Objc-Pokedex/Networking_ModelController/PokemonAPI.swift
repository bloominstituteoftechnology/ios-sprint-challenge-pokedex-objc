//
//  PokemonAPI.swift
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([PDMPokemon]?, Error?) -> Void) {
        
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
                
                let pokemon = results.compactMap { PDMPokemon(dictionary: $0) }
                completion(pokemon, nil)
                
            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func pokemonDetails(for pokemon: PDMPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw NSError()
                }
                pokemon.read(from: jsonDictionary)
                
                if let spriteURL = pokemon.sprite?.imageURL {
                    URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
                        guard error == nil else { return }
                        guard let data = data, let image = UIImage(data: data) else { return }
                        
                        pokemon.sprite?.image = image
                    }.resume()
                }
            } catch {
                NSLog("Error finding \(pokemon) details: \(error)")
                return
            }
        }.resume()
    }
}
