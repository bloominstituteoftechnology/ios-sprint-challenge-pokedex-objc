//
//  PokemonController.swift
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import Foundation

class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping (NSMutableArray?, Error?) -> Void) {
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        
        var urlComponents = URLComponents(url: allPokemonURL, resolvingAgainstBaseURL: false)
        let pokemonLimit = URLQueryItem(name: "limit", value: "1000")
        urlComponents?.queryItems = [pokemonLimit]
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                print("Error getting all pokemon data from Pokemon API")
                DispatchQueue.main.async {
                    completion(nil, NSError())
                }
                return
            }
            
            let pokemonArray = NSMutableArray()
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = jsonDictionary["results"] as? [Any] {
                        for item in results {
                            guard let pokemonDictionary = item as? [String: String] else { return }
                            let pokemon = Pokemon(dictionary: pokemonDictionary)
                            pokemonArray.add(pokemon)
                        }
                    }
                }
            } catch {
                print("Error parsing pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
            DispatchQueue.main.async {
                completion(pokemonArray, nil)
            }
            
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        if pokemon.abilities == nil, pokemon.identifier == nil, pokemon.spriteImg == nil {
            let allPokemonURL = baseURL.appendingPathComponent("pokemon")
            let singlePokemonURL = allPokemonURL.appendingPathComponent(pokemon.name.lowercased())
            
            var request = URLRequest(url: singlePokemonURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error fetching single pokemon: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("Error getting data for \(pokemon.name)")
                    return
                }
                
                do {
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let sprites = jsonDictionary["sprites"] as? [String: Any] {
                            if let spriteURLString = sprites["front_default"] as? String {
                                if pokemon.spriteImg == nil {
                                    pokemon.setValue(spriteURLString, forKey: "spriteImg")
                                }
                            }
                        }
                        
                        if let identifier = jsonDictionary["id"] as? NSNumber  {
                            pokemon.setValue(identifier, forKey: "identifier")
                        }
                        
                        guard let allAbilities = jsonDictionary["abilities"] as? [Any] else { return }
                        var abilties: [String] = []
                        for item in allAbilities {
                            guard let abilityDict = item as? [String: Any], let ability = abilityDict["ability"] as? [String: String] else { return }
                            if let abilityName = ability["name"] {
                                abilties.append(abilityName)
                            }
                        }
                        if !allAbilities.isEmpty {
                            pokemon.setValue(abilties, forKey: "abilities")
                        }
                        
                    }
                } catch {
                    print("Error parsing data for pokemon")
                    return
                }
            }.resume()
        }
    }
}
