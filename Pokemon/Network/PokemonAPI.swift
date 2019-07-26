//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

@objc(KRCPokemonAPI)
class PokemonAPI: NSObject {
    
    // MARK: - Properties
    @objc(sharded) static let shared = PokemonAPI()
    
    // MARK: -  Public Methods
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        print("Fetching All Pokemon...")
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=964")!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error calling Pokemon API: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
            
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let results = json["results"] as? Array<Dictionary<String, String>>
                else { return }
                
                
                var pokemon = [Pokemon]()
                
                for index in 0 ..< results.count {
                    
                    let pokemonData = results[index]
                    
                    guard let name = pokemonData["name"],
                    let url = pokemonData["url"]
                    else { return }
                    
                    pokemon.append(Pokemon(name: name, url: url))
                }
                
                completion(pokemon, nil)
                return
            } catch {
                
                print("Error with json: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        
        let url = URL(string: pokemon.infoURL)!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error fetching info for \(pokemon.name): \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let id = json["id"] as? Int,
                let abilitiesArray = json["abilities"] as? Array<Dictionary<String, Any>>
                else { return }
                
                var abilities = [String]()
                
                for index in 0 ..< abilitiesArray.count {
                    
                    let abilityCollection = abilitiesArray[index]
                    
                    guard let ability = abilityCollection["ability"] as? Dictionary<String, String>,
                    let name = ability["name"]
                    else { return }
                    
                    abilities.append(name)
                }
                
                pokemon.identifier = "\(id)"
                pokemon.abilities = abilities
                
//                var pokemon = [Pokemon]()
//
//                for index in 0 ..< results.count {
//
//                    let pokemonData = results[index]
//
//                    guard let name = pokemonData["name"],
//                        let url = pokemonData["url"]
//                        else { return }
//
//                    pokemon.append(Pokemon(name: name, url: url))
//                }
                
                return
                
            } catch {
                
                print("Error with json: \(error)")
                return
            }
            
            
            
            
            
        }.resume()
    }
    // MARK: - Private Methods

}
