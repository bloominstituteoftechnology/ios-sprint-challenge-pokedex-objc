//
//  PokemonAPI.swift
//  NotDigimonObjectiveC
//
//  Created by Lambda_School_Loaner_268 on 5/22/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
    @objc (sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func FetchAllPokemon(completion: @escaping ([MSKPokemon]?, Error?) -> Void) {
        
        let allPokemonURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        let session = URLSession.shared
        DispatchQueue.main.async {
            var results:[MSKPokemon] =  []
        let task = session.dataTask(with: allPokemonURL) { (data, _, error) in
            guard let data = data else {
                print("Couldn't fetch all Pokemon! -> " + String(describing: error))
                completion(nil, error)
                return
            }
            if let json: Any = try? JSONSerialization.jsonObject(with: data, options: [])  {
                if let parentDict = json as? Dictionary<String, Any> {
                    let resultsArray: [Dictionary] = parentDict["results"] as! [Dictionary<String, Any>]
                    for dict in resultsArray {
                        var mon = MSKPokemon(allDict: dict)
                        results.append(mon)
                    }
                }
                completion(results, nil)
              
            }
            
        }
        task.resume()
    }
    }
    @objc func fillInDetails(for pokemon: MSKPokemon) {
        let s = "https://pokeapi.co/api/v2/pokemon/" + (pokemon.name as String)
        let url: URL = URL(string: s)!
        let session = URLSession.shared
        DispatchQueue.main.async {
            let task = session.dataTask(with: url) { (data,
                _,
                error) in
                guard let data = data else {
                    print("Can't fill in the details!! -> " + String(describing: error))
                    return
                }
                if let json: Any = try? JSONSerialization.jsonObject(with: data,
                                                                     options: [])  {
                    if let parentDict = json as? Dictionary<String, Any> {
                        // Sprite
                        let spritesDict = parentDict["sprites"] as! Dictionary<String, String>
                        
                        pokemon.sprite = spritesDict["front_shiny"]
                        // Abilities
                        let abilitiesParentArray = parentDict["abilities"] as! Array<Dictionary
                        <String, Any>>
                        for dict in abilitiesParentArray {
                            let abilityDict: Dictionary<String, String> = dict["ability"] as! Dictionary<String, String>
                            let ability = abilityDict["name"]!
                            pokemon.abilities?.append(ability)
                        }
                        // identifier
                        pokemon.identifier = parentDict["id"] as? String
                        // url
                        pokemon.url = s
                }
                
            }
            
        }
            task.resume()
        }
        
    }
    

}
