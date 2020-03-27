//
//  Networking.swift
//  Pokedex
//
//  Created by Alexander Supe on 27.03.20.
//  Copyright © 2020 Alexander Supe. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!) { (data, _, error) in
            if let error = error { completion(nil, error); return }
            guard let data = data else { completion(nil, nil); return }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { completion(nil, nil); return }
            guard let array = dictionary["results"] as? Array<[String:String]> else { completion(nil, nil); return }
            var results = [LSIPokemon]()
            for item in array {
                results.append(LSIPokemon(dictionary: item))
            }
            completion(results, nil)
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: LSIPokemon) {
        guard let url = URL(string: pokemon.urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
            let id = dictionary["id"] as? Int
            pokemon.identifier = String(id ?? 0)
            
            guard let abDict = dictionary["abilities"] as? [[String:Any]] else { return }
            var abilities = [String]()
            for element in abDict {
                let dict = element["ability"] as? [String:String]
                guard let name = dict?["name"] else { continue }
                abilities.append(name)
            }
            pokemon.abilities = abilities
            
            guard let spDict = dictionary["sprites"] as? [String:Any] else { return }
            pokemon.sprite = spDict["front_default"] as? String
            
            guard let typeArr = dictionary["types"] as? [[String:Any]] else { return }
            guard typeArr.count > 0 else { return }
            guard let type = typeArr[0]["type"] as? [String:String] else { return }
            pokemon.type = type["name"]
            
        }.resume()
    }
}
