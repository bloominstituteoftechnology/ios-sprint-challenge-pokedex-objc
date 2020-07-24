//
//  PokemonAPI.swift
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!
    private var pokemon: [Pokemon] = []
    
    @objc(sharedController) static var shared: PokemonAPI {
        return PokemonAPI()
    }
    
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        var components = URLComponents(url: baseURL.appendingPathComponent("pokemon", isDirectory: true), resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name:"limit", value: "1000")
        ]
        
        guard let url = components?.url else {
            completion(nil, Error.self as? Error)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned: \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> else {
                    NSLog("Failed to turn JSON into dictionary")
                    return
                }
                
                let pokemonResults = PokemonResults(dictionary: json)
                
                completion(pokemonResults.pokemonArray, nil)
                
            } catch {
                NSLog("JSONSerialization failed")
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        
        let pokemonURL = baseURL.appendingPathComponent("pokemon").appendingPathComponent(pokemon.name)
        
        URLSession.shared.dataTask(with: pokemonURL) { [weak self] data, _, error in
            if let error = error {
                NSLog("Error fetching Pokemon details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching Pokemon data; no data received")
                return
            }
            
            var pokeDictionary: [String: Any]?
            do {
                pokeDictionary = try JSONSerialization
                    .jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                NSLog("Error decoding pokemon JSON: \(error)")
                return
            }
            
            guard let dictionary = pokeDictionary else {
                NSLog("Unknow error decoding pokemon JSON")
                return
            }
            
            pokemon.id = (dictionary["id"] as? NSNumber)!
            
            var abilities: [String] = []
            if let abilitiesJSONArray = dictionary["abilities"] as? [[String: Any]] {
                for abilityTopDict in abilitiesJSONArray {
                    let abilityLowerDict = abilityTopDict["ability"] as? [String: String]
                    if let abilityName = abilityLowerDict?["name"] {
                        abilities.append(abilityName)
                    }
                }
            }
            pokemon.abilities = abilities
            
            let sprites = dictionary["sprites"] as? [String: Any]
            let imageURLString = sprites?["front_default"] as? String
            if let urlString = imageURLString,
                let imageURL = URL(string: urlString) {
                pokemon.spriteURL = imageURL
                self?.fetchSprite(for: pokemon, with: imageURL)
            } else {
                NSLog("Error fetching image: \(String(describing: imageURLString))")
            }
        }.resume()
    }
    
    private func fetchSprite(for pokemon: Pokemon, with url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                NSLog("Error fetching sprite: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data")
                return
            }
            
            let sprite = UIImage(data: data)
            
            if sprite == nil {
                NSLog("Error converting image")
            }
            pokemon.sprite = sprite
        }.resume()
    }
}
