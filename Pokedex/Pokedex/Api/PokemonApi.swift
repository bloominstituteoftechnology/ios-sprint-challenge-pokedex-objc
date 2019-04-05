//
//  PokemonApi.swift
//  Pokedex
//
//  Created by Nelson Gonzalez on 4/5/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonApi: NSObject {
    @objc(pokeApi) static let shared: PokemonApi = PokemonApi()
 
    
    @objc func fetchPokemons(completion: @escaping ([NELPokemon]?, Error?) -> Void) {
        let components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemons: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let pokemonDictionary = dictionary["results"] as? [[String: Any]] else {throw NSError()}
                
                
                let pokemons = pokemonDictionary.compactMap({NELPokemon(dictionary: $0)})
                
                completion(pokemons, nil)
                
            } catch {
                return completion(nil, error)
            }
            
        }.resume()
    }
    
    @objc func fillPokemonDetails(for pokemon: NELPokemon) {
    
        let requestUrl = baseUrl.appendingPathComponent(pokemon.pokeName.lowercased())
        
        URLSession.shared.dataTask(with: requestUrl) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching results: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data from request.")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {throw NSError()}
                
              //   print(dictionary)
                
                let fetchedPoke = NELPokemon.init(dictionary: dictionary)
                
                pokemon.pokeName = fetchedPoke.pokeName
                pokemon.pokeAbilities = fetchedPoke.pokeAbilities
                pokemon.pokeId = fetchedPoke.pokeId
                pokemon.sprite = fetchedPoke.sprite
                
                
            } catch {
                NSLog("Error setting pokemon details")
            }
        }.resume()
    }
}

