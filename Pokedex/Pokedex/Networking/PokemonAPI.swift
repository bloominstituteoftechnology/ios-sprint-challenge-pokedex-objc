//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

import Foundation

@objc
class PokemonAPI: NSObject {
    
    //@objc(sharedController) let shared: PokemonAPI
    
    @objc
    func fetchAllPokemon(completion: @escaping([JDBPokemon]?, Error?) -> Void) {
        
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {data, _, error in
            
            if let error = error {
                NSLog("Error fetching pokemon data: \(String(describing: error))")
                completion(nil, error)
                return
            }
            do {
                guard let data = data else { return }
                let results = try JSONSerialization.jsonObject(with: data, options: []) as! [String: AnyObject]
                let pokemonResults = JDBPokemon()
                completion([pokemonResults], nil)
            } catch {
                NSLog("Error fetching pokemon data: \(String(describing: error))")
                completion(nil, error)
                return
            }
        }
        dataTask.resume()
    }
    
    @objc
    func fillInDetails(for pokemon: JDBPokemon) {
        
        
    }
}
