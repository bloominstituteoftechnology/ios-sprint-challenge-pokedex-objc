//
//  PokeAPI.swift
//  Pokedex-ObjC
//
//  Created by Lambda_School_Loaner_263 on 1/31/20.
//  Copyright © 2020 Lambda_School_Loaner_263. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    let baseURLString = "https://pokeapi.co/api/v2/pokemon"
    var nextURLString: String?
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([PNCPokemon]?, Error?) -> Void) {
           var url = URL(string: baseURLString)
           if let nextURLString = nextURLString {
               url = URL(string: nextURLString)
           }
        
        guard let unwrappedURL = url else { return }
            
            URLSession.shared.dataTask(with: unwrappedURL) { (data, _, error) in
                if let error = error {
                    print("Error fetching all pokemon")
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, NSError())
                    return
                }
                do {
                    guard let JSONDictionary = try JSONSerialization.jsonObject(with: data) as? NSDictionary else {
                        print("Error converting to json dictionary")
                        completion(nil, NSError())
                        return
                    }
                    
                    //print(JSONDictionary)
                    self.nextURLString = JSONDictionary["next"] as? String
                    var pokemons: [PNCPokemon] = []
                    if let pokemonDictionaries: Array = JSONDictionary["results"] as? Array<Dictionary<String, String>> {
                        for dictionary in pokemonDictionaries {
                            let pokemon = PNCPokemon(dictionary: dictionary)
                            pokemons.append(pokemon)
                        }
                        completion(pokemons, nil)
                    } else {
                        print("Error converting results to array")
                        completion(nil, NSError())
                        return
                    }
                } catch {
                    print("Error converting to json dictionary")
                    completion(nil, NSError())
                    return
                }
            }
        }
        
           @objc func fillInDetails(for pokemon: PNCPokemon) {
                
                URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
                    if error != nil {
                        print("Error fetching pokemon detail")
                        return
                    }
                    
                    guard let data = data else {
                        print("No detail data retun")
                        return
                    }
                    do {
                        guard let JSONDictionary = try JSONSerialization.jsonObject(with: data) as? NSDictionary else {
                            print("Error converting to json dictionary")
                            return
                        }
                        
                        print(JSONDictionary)
                        
                        if let id = JSONDictionary["id"] as? NSNumber {
                            pokemon.pokeId = id
                        }
                        
                        if let abilitiesArray = JSONDictionary["abilities"] as? Array<Dictionary<String, Any>> {
                            
                            var abilityString = ""
                            
                            for ability in abilitiesArray {
                                let abilityDictionary = ability["ability"] as? Dictionary<String, String>
                                let abilityName = abilityDictionary?["name"]
                                abilityString.append(contentsOf: abilityName!)
                                abilityString.append(contentsOf: "\n ")
                            }
                            
                            pokemon.abilities = abilityString
                            print(pokemon)
                        }
                        
                        if let sprites = JSONDictionary["sprites"] as? Dictionary<String, Any> {
                            
                            let imageURLString = sprites["front_default"] as? String
                            guard let imageURL = URL(string: imageURLString ?? "") else { return }
                            
                            loadImage(url: imageURL) { (imageData) in
                                pokemon.imageData = imageData
                            }
                        }
                        
                    } catch {
                        print("Error converting to json dictionary")
                        return
                    }
                }.resume()
            }
        }

