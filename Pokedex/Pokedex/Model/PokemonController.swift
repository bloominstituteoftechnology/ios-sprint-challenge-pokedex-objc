//
//  PokemonController.swift
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation


class PokemonController: NSObject {
    
    @objc private(set) var pokemons = [BVPokemon]()
    
  @objc func getPokemonResults(completion:@escaping(NSError?) -> Void = { error in }) {
        guard let resultsURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        var request = URLRequest(url: resultsURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                NSLog("failed to fetch data: \(error)")
                completion(error)
                return
            }
            
            if let response  = response as? HTTPURLResponse {
                print("\(response.statusCode)")
            }
            
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                print(String(data: data, encoding: .utf8))
                let pokemonResults = try jsonDecoder.decode(PokemonResults.self, from: data)
                print(pokemonResults)
                var results = [BVPokemon]()
                for pokemon in pokemonResults.results {
                    let bvPokemon = BVPokemon(resultsName: pokemon.name)
                    results.append(bvPokemon)
                }
                self.pokemons.append(contentsOf: results)
                print(self.pokemons.count)
            } catch {
                NSLog("error decoding data: \(error)")
            }
            completion(nil)
    }.resume()
        
    }
    @objc func getPokemon(withName name: String, completion: @escaping(NSError?) -> Void = {error in}) {
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")
        guard let pokemonURL = baseURL else { return }
        pokemonURL.appendingPathComponent(name)
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                NSLog("error fetching data: \(error)")
                completion(error)
                return
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {return }
            
            do {
                
                
            } catch {
                NSLog("error decoding json: \(error)")
            }
            
            
        }.resume()
    }

    struct PokemonResults:Decodable {
        let results = [Pokemon]()
    }
    
    struct Pokemon: Decodable {
        let name: String
    }
}
