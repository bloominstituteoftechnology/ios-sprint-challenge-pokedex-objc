//
//  PokemonAPI.swift
//  PokedexObj-C
//
//  Created by James McDougall on 3/5/21.
//

import Foundation

class PokemonAPI: NSObject {

    /// Properties
    @objc(sharedController) static let shared = PokemonAPI()
    let pokemonListURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=200&offset=200")!
    
    /// Methods
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: pokemonListURL) { (data, _, error) in
            
            if let error = error {
                print("ERROR: There was an error completing the pokemon list network request, reason: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("ERROR: No data was received in the pokemon list network request, reason: \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            do {
                let resultDictionary: [String : Any] = try JSONSerialization.jsonObject(with: data) as! Dictionary
                let resultsArray: [[String : Any]] = resultDictionary["results"] as! Array
                var pokemonArray: [LSIPokemon] = []
                
                for dictionary in resultsArray {
                    let pokemonName = dictionary["name"] as! String
                    let urlString = dictionary["url"] as! String
                    let pokemonURL = URL(string: urlString)!
                    let pokemon = LSIPokemon(name: pokemonName, dataURL: pokemonURL)
                    pokemonArray.append(pokemon)
                }
                completion(pokemonArray, nil)
                return
                
            } catch {
                print("ERROR: Could not extract pokemon from data retreived from the network request. Check 'PokemonAPI.swift' reason: \(error)")
                completion(nil, error)
                return
            }
        } .resume()
    }

    @objc func fillInDetails(for pokemon: LSIPokemon) {
        
        var request = URLRequest(url: pokemon.dataURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                print("ERROR: Could not complete individual pokemon data network request, reason: \(error)")
                return
            }
            guard let data = data else {
                print("ERROR: Data not found! Reason: \(String(describing: error))")
                return
            }
            
            do {
                //getting to the right level of each dictionary - (for abilities it's a bit deeper than this)
                let dictionary: [String : Any] = try JSONSerialization.jsonObject(with: data) as! Dictionary
                let spritesDictionary: [String : Any] = dictionary["sprites"] as! Dictionary
                let abilitiesDictionaryArray: [[String : Any]] = dictionary["abilities"] as! Array
               
                // grabbing the ability's name through multiple layers of dictionaries
                var indexCounter: Int32 = -1
                for topLevelAbilityDictionary in abilitiesDictionaryArray {
                    indexCounter += 1
                    let abilityDictionary: [String : Any] = topLevelAbilityDictionary["ability"] as! Dictionary
                    let abilityName = abilityDictionary["name"] as! String
                    pokemon.insertObject(abilityName, inAbilitiesAt: indexCounter)
                }
                
                //grabbing the values from the dictionaries above
                let spriteURL = URL(string: spritesDictionary["front_default"] as! String)!
                let identifier: Int = dictionary["id"] as! Int
                
                pokemon.setValue(NSNumber(value: identifier), forKey: "identifier")
                pokemon.setValue(spriteURL, forKey: "spriteURL")
                
            } catch {
                print("ERROR: Could not assign missing values for the pokemon in the FillInDetails method in the PokemonAPI file, reason: \(error)")
                return
            }
        }.resume()
        
    }
    
}
