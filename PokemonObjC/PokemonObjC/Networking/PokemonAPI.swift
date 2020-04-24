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
        
    }
    
    
}
