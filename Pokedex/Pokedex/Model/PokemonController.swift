//
//  PokemonController.swift
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import Foundation
import UIKit

class PokemonController: NSObject {
    
    @objc private(set) var pokemons = [BVPokemon]()
    
  @objc func fetchAllPokemon(completion:@escaping([BVPokemon]?,NSError?) -> Void) {
        guard let resultsURL = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        var request = URLRequest(url: resultsURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                NSLog("failed to fetch data: \(error)")
                completion(nil,error)
                return
            }
            
            if let response  = response as? HTTPURLResponse {
                print("\(response.statusCode)")
            }
            
            guard let data = data else { return }
            var pokemons = [BVPokemon]()
            do {
                
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let results = jsonDictionary["results"] as? [[String : Any]] else { throw NSError() }
                for dictionary in results {
                    print(dictionary)
                    let pokemon = BVPokemon(dictionary: dictionary)
                    pokemons.append(pokemon)
                }
            } catch {
                NSLog("error decoding data: \(error)")
            }
            completion(pokemons,nil)
    }.resume()
        
    }
    @objc func getPokemon(withName name: String, completion: @escaping(BVPokemon?,NSError?) -> Void) {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(name)
        guard let pokemonURL = baseURL else { return }
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        print(request)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                NSLog("error fetching data: \(error)")
                completion(nil,error)
                return
            }
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let data = data else {return }
            var pokemon = BVPokemon()
            do {
            guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { throw NSError() }
                let pokemonDictionary = BVPokemon(dictionary: jsonDictionary)
                pokemon = pokemonDictionary
                print(jsonDictionary)
            } catch {
                NSLog("error decoding json: \(error)")
            }
            completion(pokemon,nil)
        }.resume()
    }

    @objc func getimage(_ imageURL: String, completion:@escaping(UIImage?, NSError?) ->Void) {
        guard let imageURL = URL(string: imageURL) else { return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                       NSLog("error fetching data: \(error)")
                       completion(nil,error)
                       return
                   }
                   if let response = response as? HTTPURLResponse {
                       print(response.statusCode)
                   }
                   
                   guard let data = data else {return }
                
                    let image = UIImage(data: data)
                    completion(image,nil)
        }.resume()
    }
    
    struct PokemonResults:Decodable {
        let results = [Pokemon]()
    }
    
    struct Pokemon: Decodable {
        let name: String
    }
}
