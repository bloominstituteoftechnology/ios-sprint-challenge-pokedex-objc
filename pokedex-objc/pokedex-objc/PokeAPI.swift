//
//  PokeAPI.swift
//  pokedex-objc
//
//  Created by Bradley Yin on 10/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
class PokemonAPI: NSObject {
    
    let baseURLString = "https://pokeapi.co/api/v2/pokemon"
    var nextURLString: String?

    @objc(sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([BYPokemon]?, Error?) -> Void) {
        var url = URL(string: baseURLString)
        if let nextURLString = nextURLString {
            url = URL(string: nextURLString)
        }
        
        guard let unwrappedURL = url else { return }
        
        URLSession.shared.dataTask(with: unwrappedURL) { (data, _, error) in
            if let error = error {
                print("error fetching all pokemon")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            do {
                guard let JSONDictionary = try JSONSerialization.jsonObject(with: data) as? NSDictionary else {
                    print("error converting to json dictionary")
                    completion(nil, NSError())
                    return
                }
                self.nextURLString = JSONDictionary["next"] as? String
                var pokemons: [BYPokemon] = []
                if let pokemonDictionaries: Array = JSONDictionary["results"] as? Array<Dictionary<String, String>> {
                    for dictionary in pokemonDictionaries {
                        let pokemon = BYPokemon(dictionary: dictionary)
                        pokemons.append(pokemon)
                    }
                    completion(pokemons, nil)
                } else {
                    print("error converting results to array")
                    completion(nil, NSError())
                    return
                }
            } catch {
                print("error converting to json dictionary")
                completion(nil, NSError())
                return
            }
        }
    }

    @objc func fillInDetails(for pokemon: BYPokemon) {
        
    }
}
