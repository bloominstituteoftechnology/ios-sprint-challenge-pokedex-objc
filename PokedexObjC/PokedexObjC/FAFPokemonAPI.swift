//
//  FAFPokemonAPI.swift
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class FAFPokemonAPI: NSObject {
    
    override init() {
        let cache = URLCache(memoryCapacity: 16*1024*1024, diskCapacity: 100 * 1024 * 1024, diskPath: nil)
        URLCache.shared = cache
    }
    
    @objc(pokemons) var pokemons = [FAFPokemon]()

    @objc(sharedController) static let shared = FAFPokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([FAFPokemon]?, Error?) -> Void)
    {
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error returning data from data task: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("Data unavailable: \(String(describing: error))")
                return completion(nil, error)
            }
            
            do{
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let pokemonDict = dictionary["results"] as? [[String: Any]] else {
                        throw NSError()
                }
                
                let pokemons = pokemonDict.compactMap({FAFPokemon(dictionary: $0)})
                completion(pokemons, nil)
                
            }catch {
                    NSLog("Error getting dictionary of results: \(error)")
                    return completion(nil, error)
                }
            
        }.resume()
        
    }
    
    @objc func fillInDetails(for pokemon: FAFPokemon)
    {
        let requestURL = URL(string: pokemon.detailURL)!
        let request = URLRequest(url: requestURL);
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetch pokemon details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Data for pokemon details unavailible: \(String(describing: error))")
                return
            }
            
            do{
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    
                    let weight = dictionary["weight"] as? Int,
                    let baseXP = dictionary["base_experience"] as? Int,
                    let pokemonID = dictionary["id"] as? Int,
                    var spritesDict = dictionary["sprites"] as? [String: Any],
                    let typesDict = dictionary["types"] as? [[String: Any]],
                    let abilitiesDict = dictionary["abilities"] as? [[String: Any]] else
                {
                        throw NSError()
                        
                }
                
                let photoURL = spritesDict["front_default"] as! String
                
                var abilitiesArray = [String]()

                for abilityDict in abilitiesDict
                {
                    let innerAbility = abilityDict["ability"] as! [String: Any]
                    let name = innerAbility["name"] as! String
                    abilitiesArray.append(name)
                }
                
                var typesArr = [String]()
                
                for type in typesDict
                {
                    let innerType = type["type"] as! [String: Any]
                    let name = innerType["name"] as! String
                    typesArr.append(name)
                }
                
                
//                self.pokemons[pokemonID] = FAFPokemon(name: pokemon.name, pokemonID: pokemon.pokemonID, detailURL: pokemon.detailURL, weight: weight, baseXP: baseXP, imageURL: photoURL, abilities: [], types: [])
                
                pokemon.imageURL = photoURL
                pokemon.abilities = abilitiesArray
                pokemon.types = typesArr
                pokemon.pokemonID = pokemonID
                pokemon.baseXP = baseXP
                pokemon.weight = weight
                
            }catch {
                NSLog("Error getting dictionary of results: \(error)")
                return
            }
            
        }.resume()
    }
    
}
