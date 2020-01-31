//
//  PokemonController.swift
//  ObjCPokedex
//
//  Created by Jerry haaser on 1/31/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

enum HTTPMethod: String {
    
    case get = "GET" // read only
    case put = "PUT" // create data
    case post = "POST" // update or replace data
    case delete = "DELETE" // delete data
    
}

import UIKit

class PokemonController: NSObject {
    
    @objc static let shared = PokemonController()
    
    @objc var pokedex: [JPHPokedexPokemon] = []
    
    @objc var pokemon: JPHPokemon?
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([JPHPokedexPokemon]?, Error?) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error  {
                NSLog("Error with dataTask: \(error)")
                completion(nil,error)
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(nil, error)
                return
            }
            
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {return}
                
                if let results = jsonDictionary["results"] as? [[String : Any]] {
                    for pokemon in results {
                        guard let poke = JPHPokedexPokemon.init(dictionary: pokemon) else {return}
                        self.pokedex.append(poke)
                    }
                }
                
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                completion(nil, error)
                return
            }
            completion(self.pokedex, nil)
        }.resume()
    }
    
   func fillInDetails(for pokemon: JPHPokedexPokemon, completion: @escaping (JPHPokemon?, Error?) -> Void) {
        guard let url = URL(string: pokemon.url) else {return}
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        // pass in URL for network request
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error  {
                NSLog("Error with dataTask: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data")
                return
            }
            
            do {
               guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {return}
                 guard let pokemon = JPHPokemon.init(dictionary: jsonDictionary) else {return}
                self.pokemon = pokemon
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding pokemon: \(error)")
                return
            }
            completion(self.pokemon,nil)
        }.resume()
    }
}
