//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Dennis Rudolph on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    @objc(sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error while fetching all pokemon \(error)")
                completion(nil, error);
                return
            }
            
            guard let data = data else {
                NSLog("Data for fetching all pokemon was nil")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    NSLog("Fetch All pokemon didn't return a dictionary")
                    completion(nil, NSError())
                    return
                }
                
                guard let results = dictionary["results"] as? NSArray else {
                    NSLog("Fetch all pokemon didn't contain results array")
                    completion(nil, NSError())
                    return
                }
                
                var fetchedPokemon = [Pokemon]()
                for pokemonDict in results {
                    let pokemon = Pokemon.init(dictionary: pokemonDict as! [String : Any])
                    if let pokemon = pokemon {
                        fetchedPokemon.append(pokemon)
                    }
                }
                completion(fetchedPokemon, nil)
            } catch {
                NSLog("Error parsing JSON")
                completion(nil, error);
                return
            }
        }.resume()
    }
}
