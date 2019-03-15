//
//  PokemonImporter.swift
//  PokeC
//
//  Created by Lotanna Igwe-Odunze on 3/15/19.
//  Copyright © 2019 Sugabelly LLC. All rights reserved.
//

import Foundation

@objc class PokemonImporter: NSObject {
    
    @objc static let shared: PokemonImporter = PokemonImporter()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
   //Grab 50 pokemon
    @objc func grabPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let limitQuery = URLQueryItem(name: "limit", value: "50")
        components.queryItems = [limitQuery]
        
        let requestURL = components.url!
        var pokeList: [Pokemon] = []
        
        let datatask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data was returned... ")
                completion(nil, nil)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = json["results"] as! [[String: String]]
                for result in results {
                    if let pokemon = Pokemon(dictionary: result) {
                        pokeList.append(pokemon)
                    }
                }
                completion(pokeList, nil)
            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(nil, error)
            }
        }
        datatask.resume()
    }
    
    //Get information for each Pokemon
    @objc func grabPokemonInfo(for pokemon: Pokemon) {
        
        let datatask = URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                NSLog("Couldn't get info for pokemon: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No pokemon data found.")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                pokemon.fillIn(with: json)
                
            } catch {
                NSLog("Couldn't decode Pokemon info: \(error)")
            }
        }
        
        datatask.resume()
    }
}
