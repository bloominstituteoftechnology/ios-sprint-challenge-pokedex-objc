//
//  PokemonAPI.swift
//  Pokedex-Obj-C
//
//  Created by scott harris on 4/24/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([SAHPokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        
        let urlRequest = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                NSLog("Network Error received: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                let dataError = NSError(domain: "com.sah.Pokedex", code: 100, userInfo: ["message": "Data was nil"])
                completion(nil, dataError)
                return
            }
            
            do {
                let pokemon = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                var pokemonArray: [SAHPokemon] = []
                
                if let pokemonDictionaryArray = pokemon["results"] as? [[String: Any]] {
                    for pokemanDictionary in pokemonDictionaryArray {
                        let pokemanObject = SAHPokemon(dictionary: pokemanDictionary)
                        pokemonArray.append(pokemanObject)
                    }
                }
                completion(pokemonArray, nil)
                
            } catch {
                print("Error parsing pokemon: \(error)")
                completion(nil, error)
            }

        }.resume()
        
        
    }
    
    @objc func fillInDetails(for pokemon: SAHPokemon) {
        let requestURL = baseURL.appendingPathComponent("pokemon").appendingPathComponent(pokemon.name)
        
        let urlRequest = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                NSLog("Network Error received: \(error)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let pokemonDict = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                self.parsePokemon(pokemonDict, for: pokemon)
                
            } catch {
                print("Error parsing pokemon: \(error)")
            }
            
        }.resume()
        
        
    }
    
    private func parsePokemon(_ pokemonDict: [String: Any], for pokemon: SAHPokemon) {
        if let id = pokemonDict["id"] as? Int {
                pokemon.identifier = NSNumber(value: id)
        }
        
        
        var abilitiesStrings: [String] = []
        guard let abilitiesArray = pokemonDict["abilities"] as? [[String: Any]] else { return }
        for ability in abilitiesArray {
            guard let abilityDictionary = ability["ability"] as? [String:String] else { return }
            if let name = abilityDictionary["name"] {
                abilitiesStrings.append(name)
            }
        }
        
        pokemon.abilities = abilitiesStrings

        if let sprite = pokemonDict["sprites"] as? [String: String?] {
            if let url = sprite["front_default"] as? String {
                if let url = URL(string: url) {
                    if let data = try? Data(contentsOf: url) {
                        pokemon.imageData = data
                    }
                }
                
            }
        }
        
        
    }
}
