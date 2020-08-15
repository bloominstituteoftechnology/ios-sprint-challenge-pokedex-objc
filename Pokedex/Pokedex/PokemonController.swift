//
//  PokemonController.swift
//  Pokedex
//
//  Created by Claudia Maciel on 8/14/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import Foundation

class PokemonController: NSObject {

 private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!

    @objc(sharedController) static var shared: PokemonController {
        return PokemonController()
    }

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let pokemonURL = baseURL.appendingPathComponent("pokemon")

        URLSession.shared.dataTask(with: pokemonURL) { data, _, error in
            if let error = error {
                return completion(nil, error)
            }

            guard let data = data else {
                let dataError = NSError()
                return completion(nil, dataError)
            }

            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> else {
                    NSLog("Unable to decode json")
                    return
                }

                let pokemonResults = PokemonResults(dictionary: json)

                completion(pokemonResults.pokemonArray, nil)
            } catch {
                NSLog("Unable to addd to dictionary")
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        let singlePokemonURL = baseURL.appendingPathComponent("pokemon").appendingPathComponent(pokemon.name)

               URLSession.shared.dataTask(with: singlePokemonURL) { data, _, error in
                   if let error = error {
                       NSLog("Failed to fetch image with error: \(error)")
                       return
                   }

                   guard let data = data else {
                       NSLog("Data was nil")
                       return
                   }

                   do {
                       guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any> else {
                           NSLog("Failed to turn json into dictionary")
                           return
                       }

                       DispatchQueue.main.async {
                        pokemon.fillInDetails(forPokemon: json)
                       }
                   } catch {
                       NSLog("Failed to do whatever JSONSerialization does: \(data)")
                   }
               }.resume()
    }
}
