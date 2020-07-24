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

    @objc (shared) static let shared = PokemonController()
    
    @objc func getAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let urlString = "/api/v2/pokemon/?limit=850"
        let pokemonURL = URL(string: urlString, relativeTo: baseURL)!
        
        NSLog("%@", pokemonURL.absoluteString)
        
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
    
    @objc func getPokemonDetail(for pokemon: Pokemon) {
        let urlString = "/api/v2/pokemon/\(pokemon.name.lowercased())"
        let pokemonURL = URL(string: urlString, relativeTo: baseURL)!
        
        NSLog("Pokemon URL: %@", pokemonURL.absoluteString)
        
        if (pokemon.abilities != nil || pokemon.identifier != nil || pokemon.sprite != nil || pokemon.type != nil) {
            return
        }
        
        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in
            guard let data = data else {
                NSLog("Data from pokemon detail null")
                return
            }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                NSLog("JSON object unable to be deserialized")
                return
            }
             
            if let id = dictionary["id"] as? Int {
                pokemon.identifier = NSNumber(value: id)
            }
            
            if let abilities = dictionary["abilities"] as? [[String:Any]] {
                var abilitiesString = ""
                
                for entry in abilities {
                    if let ability = entry["ability"] as? [String:String] {
                        if let name = ability["name"] {
                            abilitiesString += "\(name.capitalized) "
                        }
                    }
                }
                
                pokemon.abilities = abilitiesString
                NSLog("%@", abilitiesString)
            }
            
            if let types = dictionary["types"] as? [[String:Any]] {
                var typesString = ""
                
                for entry in types {
                    if let type = entry["type"] as? [String:String] {
                        if let name = type["name"] {
                            typesString += "\(name.capitalized) "
                        }
                    }
                }
                
                pokemon.type = typesString
                NSLog("%@", typesString)
            }
            
            if let sprites = dictionary["sprites"] as? [String:String] {
                if let spriteURL = sprites["front_default"] {
                    pokemon.sprite = spriteURL
                    NSLog("Sprite URL: %@", spriteURL)
                }
            }
            
        }.resume()
    }
}
