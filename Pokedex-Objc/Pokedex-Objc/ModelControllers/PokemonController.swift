//
//  PokemonController.swift
//  Pokedex-Objc
//
//  Created by Hunter Oppel on 6/19/20.
//  Copyright © 2020 LambdaSchool. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!

    @objc(sharedController) static var shared: PokemonAPI {
        return PokemonAPI()
    }

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon")
        
        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in
            if let error = error {
                return completion(nil, error)
            }
            
            guard let data = data else {
                let dataError = NSError(domain: "com.Pokedex-Objc.hunteroppel", code: 100, userInfo: [NSLocalizedDescriptionKey: "Data was nil"])
                return completion(nil, dataError)
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> else {
                    NSLog("Yup decoding failed")
                    return
                }
                
                let pokemonResults = PokemonResults(dictionary: json)
                
                completion(pokemonResults.pokemonArray, nil)
            } catch {
                NSLog("Failed to turn json into dictionary")
            }
        }
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
}
