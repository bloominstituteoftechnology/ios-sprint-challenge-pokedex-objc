//
//  PokemonAPI.swift
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

@objc
class PokemonAPI: NSObject {
    
    // MARK: Properties
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc private var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    @objc var pokemonResults: [Pokemon] = []
    //    @objc private(set) var pokemon: Pokemon? = nil
    
    // MARK: Initializing after fetching Pokemon Results
    override init() {
        super.init()
        
        self.fetchAllPokemon { (pokemonResults, error) in
            
            if let error = error {
                print("Error initializing with pokemon array: \(error)")
                return
            }
            self.pokemonResults = pokemonResults!
        }
    }
    
    // MARK: fetch ALL Pokemon
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data , response, error) in
            
            if let error = error {
                print("Error: \(error)")
                completion(nil,error)
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Response Code: \(response.statusCode)")
                completion(nil,error)
                return
            }
            
            guard let data = data else {
                completion(nil,error)
                return
            }
            print("\nData returned when fetching all pokemon: \(data)")
            
            do {
                
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Bad Decode fetchinf all pokemon")
                    return
                }
                print("Decoded jsonDictionary: \(jsonDictionary)")
                
                if let resultsDictionary = jsonDictionary["results"] as? [[String: String]] {
                    
                    for pokemon in resultsDictionary {
                        let newPokemon = Pokemon(dictionary: pokemon)
                        self.pokemonResults.append(newPokemon)
                    }
                }
                
                completion(self.pokemonResults,nil)
                return
            } catch {
                print("Error: \(error)")
                completion(nil,error)
                return
            }
        }.resume()
    }
}
