//
//  FAFPokemonAPI.swift
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class FAFPokemonAPI: NSObject {

    @objc(sharedController) static let shared = FAFPokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([FAFPokemon]?, Error?) -> Void)
    {
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error returning data from data task: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("Data unavailable: \(String(describing: error))")
                return completion(nil, error)
            }
            
            do{
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let pokemonDict = dictionary["results"] as? [[String: Any]] else {
                        throw NSError()
                }
                
                let pokemons = pokemonDict.compactMap({FAFPokemon(dictionary: $0)})
                completion(pokemons, nil)
                
            }catch {
                    NSLog("Error getting dictionary of results: \(error)")
                    return completion(nil, error)
                }
            
        }.resume()
        
    }
    
    @objc func fillInDetails(for pokemon: FAFPokemon)
    {
        
    }
    
}
