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
        URLSession.shared.dataTask(with: pokemon.detailURL) { [weak self] data, response, error in
            print("URL: \(pokemon.detailURL)")

            if let error = error {
                NSLog("Error fetching Pokemon details: \(error)")
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode > 299
            {
                NSLog("Error fetching Pokemon data; bad response: \(response)")
                return
            }
            guard let data = data else {
                NSLog("Error fetching Pokemon data; no data received")
                return
            }

            var pokemonDictionary: [String: Any]?
            do {
                pokemonDictionary = try JSONSerialization
                    .jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                NSLog("Error decoding pokemon JSON: \(error)")
                return
            }
            guard let dict = pokemonDictionary else {
                NSLog("Unknown error decoding pokemon JSON")
                return
            }

            // Get id
            pokemon.identifier = dict["id"] as? String

            // Get abilities
            var abilities: [String] = []
            if let abilitiesDictionary = dict["abilities"] as? [[String: Any]] {
                for ability in abilitiesDictionary {
                    let abilityDetail = ability["ability"] as? [String: String]
                    if let name = abilityDetail?["name"] {
                        abilities.append(name)
                    }
                }
            }
            pokemon.abilities = abilities

            // Get sprite URL and load image
            let sprites = dict["sprites"] as? [String: Any]
            let imageURLString = sprites?["front_default"] as? String
            if let urlString = imageURLString,
                let imageURL = URL(string: urlString) {
                pokemon.imageURL = imageURL
                self?.fetchImage(for: pokemon, with: imageURL)
            } else {
                NSLog("Invalid image url: \(imageURLString ?? "Missing URL")")
            }

            print("Loaded Pokemon detail")
        }.resume()
    }

    private func fetchImage(for pokemon: MTGPokemon, with url: URL) {
        NSLog("Load image url: \(url)")
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                NSLog("Error fetching Pokemon sprite: \(error)")
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode > 299
            {
                NSLog("Error fetching Pokemon sprite; bad response: \(response)")
                return
            }
            guard let data = data else {
                NSLog("Error fetching Pokemon sprite; no data received")
                return
            }

            // Convert the data object to an image
            let image = UIImage(data: data)
            if image == nil {
                NSLog("Error converting fetched data to sprite image")
            }
            pokemon.image = image
            print("Loaded Pokemon image")
        }.resume()
    }

}


