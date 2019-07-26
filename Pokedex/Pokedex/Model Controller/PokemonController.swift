//
//  PokemonController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 7/26/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonController: NSObject {
    @objc(pokeApi) static let shared: PokemonController = PokemonController()
    
    @objc func fetchPokemon(completion: @escaping ([HHPokemon]?, Error?) -> Void) {
        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        let url = components.url!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let pokemonDictionary = dictionary["results"] as? [[String: Any]] else { throw NSError() }
                let pokemon = pokemonDictionary.compactMap({ HHPokemon(dictionary: $0) })
                completion(pokemon, nil)
            } catch {
                return completion(nil, error)
            }
            }.resume()
    }
    
    @objc func fillPokemonDetails(for pokemon: HHPokemon) {
        let requestURL = baseURL.appendingPathComponent(pokemon.pokeName.lowercased())
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching results: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data from request")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                
                let fetchedPokemon = HHPokemon.init(dictionary: dictionary)
                
                pokemon.pokeName = fetchedPokemon.pokeName
                pokemon.pokeID = fetchedPokemon.pokeID
                pokemon.pokeAbilities = fetchedPokemon.pokeAbilities
                pokemon.sprite = fetchedPokemon.sprite
                
            } catch {
                NSLog("Error setting pokemon details")
            }
            }.resume()
    }
}
