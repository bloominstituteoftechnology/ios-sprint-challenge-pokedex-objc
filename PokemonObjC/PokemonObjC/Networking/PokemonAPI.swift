//
//  PokemonAPI.swift
//  PokemonObjC
//
//  Created by Chris Gonzales on 4/24/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([CDGPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error fetching Pokemon: \(String(describing: error))")
                completion(nil, error)
                return
            }
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                completion(nil, nil)
                return
            }
            guard let array = dictionary["results"] as? Array<[String:String]> else { completion(nil, nil)
                return
            }
            var results = [CDGPokemon]()
            for pokemon in array {
                results.append(CDGPokemon(dictionary: pokemon))
            }
            completion(results, nil)
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: CDGPokemon) {
        
        guard let url = URL(string: pokemon.urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
            
            let idInt = dictionary["id"] as? Int
            pokemon.identifier = String(idInt ?? 0)
            
            guard let abilitiesDict = dictionary["abilities"] as? [[String:Any]] else { return }
            
            var abilities = [String]()
            for element in abilitiesDict {
                let dict = element["ability"] as? [String:String]
                guard let name = dict?["name"] else { continue }
                abilities.append(name)
            }
            pokemon.abilities = abilities
            
            guard let spriteDict = dictionary["sprites"] as? [String:Any] else { return }
            
            pokemon.sprite = spriteDict["front_default"] as? String
        }.resume()
    }
}
