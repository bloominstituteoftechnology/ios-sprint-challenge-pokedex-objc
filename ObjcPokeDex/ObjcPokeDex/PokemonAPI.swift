//
//  PokemonAPI.swift
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()
   
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        let request = URLRequest(url: requestURL)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemons: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error with fetch all pokemon data: \(String(describing: error))")
                completion(nil, error)
                return
            }
            do {
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let results = jsonDict["results"] as? [[String:Any]]  else {throw NSError()}
                let allPokemons = results.compactMap {LSIPokemon(dictionaryToGetNameAndURL: $0)}
                completion(allPokemons, nil)
            }catch {
                NSLog("Error decoding all pokemons: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: LSIPokemon) {
        
    }
    
}
