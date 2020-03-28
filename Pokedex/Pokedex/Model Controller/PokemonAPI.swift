//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Michael on 3/27/20.
//  Copyright © 2020 Michael. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc var pokemon: [MBMPokemon] = []
    
    @objc func fetchAllPokemon(completion: @escaping ([MBMPokemon]?, Error?) -> Void) {
        let url = baseURL.appendingPathComponent("pokemon")
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        urlComponents?.queryItems = [
            URLQueryItem.init(name: "offset", value: "20"),
            URLQueryItem.init(name: "limit", value: "964")
        ]
        
        guard let pokemonURL = urlComponents?.url else {
            print("no pokemonURL exists in fetchAllPokemon method")
            return
        }
        print(pokemonURL)
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching all pokemon: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            guard let data = data else {
                print("Bad or No data returned from data task.")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            do {
                
                let fetchedPokemon = try JSONSerialization.jsonObject(with: data, options: [])
                let allPokemon = MBMPokemonResults(dictionary: fetchedPokemon as! [AnyHashable : Any])
                print(fetchedPokemon)
               
                DispatchQueue.main.async {
                    completion(allPokemon.pokemon, nil)
                }
            } catch {
                print("Error parsing pokemon: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: MBMPokemon) {
        let url = pokemon.detailURL
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching selected pokemon: \(error)")
                return
            }
            guard let data = data else {
                print("Bad or No data returned from data task.")
                return
            }
            do {
                let fetchedPokemon = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                print(fetchedPokemon)
                
                
                let updatedPokemon = pokemon.update(with: fetchedPokemon, pokemon: pokemon)
                pokemon.frontImage = updatedPokemon.frontImage
                pokemon.identifier = updatedPokemon.identifier
                pokemon.ability = updatedPokemon.ability
               
            } catch {
                print("Error parsing pokemon: \(error)")
                return
            }
        }.resume()
    }
}
