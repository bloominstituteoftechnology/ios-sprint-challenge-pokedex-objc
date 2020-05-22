//
//  APIController.swift
//  Pokedex
//
//  Created by Tobi Kuyoro on 22/05/2020.
//  Copyright © 2020 Tobi Kuyoro. All rights reserved.
//

import Foundation

@objcMembers
class APIController: NSObject {

    @objc(sharedController) static let shared = APIController()

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    var pokedex: [Pokemon] = []

    // MARK: - Networking

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let request = URLRequest(url: baseURL)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error with request to fetch pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }

            do {
                guard let pokemonJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let resultsJSON = pokemonJSON["results"] as? [[String: String]] else { return }

                for result in resultsJSON {
                    let pokemon = Pokemon(dictionary: result)
                    self.pokedex.append(pokemon)
                    completion(self.pokedex, nil)
                }
            } catch {
                NSLog("Error decoding pokemon results: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: Pokemon, completion: @escaping (Pokemon?) -> Void) {
        let url = pokemon.url
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("Error with request for \(pokemon.name): \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                NSLog("No data for \(pokemon.name)")
                completion(nil)
                return
            }

            do {
                guard
                    let pokemonJSON = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let identifier = pokemonJSON["id"] as? Int,
                    let name = pokemonJSON["name"] as? String,
                    let spritesJSON = pokemonJSON["sprites"] as? [String: Any],
                    let sprite = spritesJSON["front_default"] as? String,
                    let abilitiesArray = pokemonJSON["abilities"] as? [[String: Any]] else { return }
                pokemon.identifier = NSNumber(integerLiteral: identifier)
                pokemon.name = name
                pokemon.sprite = URL(string: sprite)
                let abilities: NSMutableArray = []
                for ability in abilitiesArray {
                    if let abilityJSON = ability["ability"] as? [String: String],
                        let abilityName = abilityJSON["name"] {
                        abilities.add(abilityName)
                        pokemon.abilities = abilities
                    }
                }
            } catch {
                NSLog("Error getting details for \(pokemon.name): \(error)")
                completion(nil)
                return
            }

            completion(pokemon)
        }.resume()
    }
}
