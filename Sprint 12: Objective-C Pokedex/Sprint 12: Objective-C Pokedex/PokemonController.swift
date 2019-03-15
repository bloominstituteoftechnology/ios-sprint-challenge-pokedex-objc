//
//  PokemonController.swift
//  Sprint 12: Objective-C Pokedex
//
//  Created by Ivan Caldwell on 3/15/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

import Foundation
import UIKit

class PokemonController: NSObject {
    @objc(sharedController) static let shared: PokemonController = PokemonController()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    // Fetch the all the pokemons
    @objc func fetchAllPokemon(completion: @escaping ([IACPokemon]?, Error?) -> Void) {
        var pokemons: [IACPokemon] = []
        let request = URLRequest(url: baseURL)
        let datatask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error: No data returned from data task")
                completion(nil, NSError())
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = json["results"] as! [[String: String]]
                for result in results {
                    if let pokemon = IACPokemon(pokemonDictionary: result) {
                        pokemons.append(pokemon)
                    }
                }
                completion(pokemons, nil)
            } catch {
                NSLog("Unable to decode data: \(error)")
                completion(nil, error)
            }
        }
        datatask.resume()
    }
    
    // Fetch data to fill in the Pokemon data
    @objc func fillInDetails(for pokemon: IACPokemon) {
        let datatask = URLSession.shared.dataTask(with: pokemon.pokemonURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon additional information: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Error: No data returned from data task")
                return
            }
            do {
                let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                pokemon.fill(inPokemonDictionary: pokemonDictionary)
            } catch {
                NSLog("Error decoding Pokemon details: \(error)")
            }
        }
        datatask.resume()
    }
}
