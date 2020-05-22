//
//  PokedexFetcher.swift
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class PokemonAPI: NSObject {

    // MARK: - Properites
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2")!
    private let backupBaseUrl = URL(string: "https://lambdapokeapi.herokuapp.com/")!

    @objc(sharedController)
    static let shared = PokemonAPI()

    override private init() {}

    @objc func fetchAllPokemon(completion: @escaping ([MTGPokemon]?, Error?) -> Void) {
        let apiUrl = baseUrl.appendingPathComponent("pokemon/")

        var request = URLRequest(url: apiUrl)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { data, response, error in
            print("URL: \(apiUrl)")

            if let error = error {
                NSLog("Error receiving pokemon data: \(error)")
                completion(nil, error)
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                // User is not authorize (no token or bad token)
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, error)
                return
            }

            var pokemonDictionary: [String: Any]?

            do {
                pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch let error as NSError {
                print("Error during JSONSerialization: \(error.localizedDescription)")
                completion(nil, error)
            }

            // This high level object contains 4 items. We only care about results.
            guard let resultsArray = pokemonDictionary!["results"] as? [[String: String]] else {
                    print("Error getting results")
                    completion(nil, error)
                    return
            }

            // We now have all the results.
            var pokemonArray: [MTGPokemon] = []
            for aPokemonDict in resultsArray {
                let pokemon = MTGPokemon(dictionary: aPokemonDict)
                if let pokemon = pokemon {
                    pokemonArray.append(pokemon)
                } else {
                    print("Error decoding Pokemon")
                }
            }
            completion(pokemonArray, nil)

        }.resume()
    }

    @objc func fillInDetails(for pokemon: MTGPokemon) {

    }
}


