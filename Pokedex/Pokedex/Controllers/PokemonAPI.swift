//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Nathanael Youngren on 4/12/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import UIKit

enum URLSessionError: Error {
    case dataFetching
    case dataConversion
}

class PokemonAPI: NSObject {
    
    @objc(fetchAllPokemonWithCompletion:)
    func fetchAllPokemon(completion: @escaping ([NYCPokemon]?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("Error fetching Pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error unwrapping data")
                completion(nil, URLSessionError.dataFetching)
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                let results = response.value(forKey: "results") as! NSArray
                var pokemon: [NYCPokemon] = []
                for result in results {
                    let singlePokemon = NYCPokemon(dictionary: (result as! NSDictionary) as! [AnyHashable : Any])
                    pokemon.append(singlePokemon)
                }
                completion(pokemon, nil)
                return
            } catch {
                print("Error converting data")
                completion(nil, URLSessionError.dataConversion)
                return
            }
        }
        
        task.resume()
    }
    
    @objc func fillInDetails(for pokemon: NYCPokemon) {
        
        let task = URLSession.shared.dataTask(with: pokemon.detailURL) { (data, _, error) in
            if let error = error {
                print("Error fetching Pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error unwrapping data")
                return
            }
            
            do {
                let pokemonDetails = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let abilities = pokemonDetails["abilities"] as! [AnyObject]
                var pokemonAbilities: [NSString] = []
                for ability in abilities {
                    let abilityName = ability["ability"] as! [String: Any]
                    let name = abilityName["name"] as! NSString
                    pokemonAbilities.append(name)
                }
                let id = pokemonDetails["id"] as! NSNumber
                let sprites = pokemonDetails["sprites"] as! [String: Any]
                let spriteURLString = sprites["front_default"] as! String
                let spriteURL = URL(string: spriteURLString)!
                
                pokemon.abilities = pokemonAbilities
                pokemon.identifier = id
                pokemon.spriteURL = spriteURL
                return
            } catch {
                print(URLSessionError.dataConversion)
                return
            }
        }
        
        task.resume()
    }
    
    @objc(fetchImageWithURL:completionBlock:)
    func fetchImage(with url: URL, completion: @escaping (Data?, Error?) -> Void) {
        
        let imageTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error during URLSession: \(error).")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error fetching data.")
                completion(nil, URLSessionError.dataFetching)
                return
            }
            
            completion(data, nil)
        }
        
        imageTask.resume()
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    @objc(sharedController) static let shared = PokemonAPI()
}
