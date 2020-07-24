//
//  PokemonController.swift
//  Pokedex
//
//  Created by Vincent Hoang on 7/24/20.
//  Copyright © 2020 Vincent Hoang. All rights reserved.
//

import UIKit

@objc class PokemonController: NSObject {
    let baseURL = URL(string: "https://pokeapi.co")

    @objc static let shared = PokemonController()
    
    @objc func getAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let urlString = "/api/v2/pokemon/?limit=850"
        let pokemonURL = URL(string: urlString, relativeTo: baseURL)!
        
        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                NSLog("Data found to be nil")
                return
            }
            
            guard let outer = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                completion(nil, nil)
                NSLog("Unable to decode json object")
                return
            }
            
            guard let inner = outer["results"] as? Array<[String:String]> else {
                completion(nil, nil)
                return
            }
            
            var pokemonArray = [Pokemon]()
            
            for pokemon in inner {
                pokemonArray.append(Pokemon(dict: pokemon))
            }
            completion(pokemonArray, nil)
        }.resume()
    }
}
