//
//  PokemonAPI.swift
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {

    private(set) var pokemon: [Pokemon] = []

    private var baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!

    @objc(sharedController)
    static let shared = PokemonAPI()

    override private init() {}

    @objc
    func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        var components = URLComponents(
            url: baseURL.appendingPathComponent("pokemon", isDirectory: true),
            resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "20000")
        ]
        guard let url = components?.url else {
            completion(nil, errorWithMessage("Error fetching pokemon; bad url", LSIAPIError.rawValue))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            if let response = response as? HTTPURLResponse,
                response.statusCode < 200 || response.statusCode > 299
            {
                completion(nil, errorWithMessage("Error fetching Pokemon data; bad response: \(response)", LSIAPIError.rawValue))
                return
            }

            guard let data = data else {
                completion(nil, errorWithMessage("Error fetching Pokemon data; no data received", LSIDataNilError.rawValue))
                return
            }

            var pokemonDict: [String: Any]?
            do {
                pokemonDict = try JSONSerialization
                    .jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                completion(nil, error)
                return
            }
            guard
                let dict = pokemonDict,
                let resultsArray = dict["results"] as? [[String: String]]
                else {
                    completion(nil, errorWithMessage("Error decoding Pokemon data", LSIJSONDecodeError.rawValue))
                    return
            }
            var decodeError: Error?
            var pokemonArray: [Pokemon] = []
            for thisPokemonDict in resultsArray {
                let pokemon = Pokemon(dictionary: thisPokemonDict)
                if let pokemon = pokemon {
                    pokemonArray.append(pokemon)
                } else {
                    decodeError = errorWithMessage("Error decoding individual pokemon", LSIJSONDecodeError.rawValue)
                }
            }
            completion(pokemonArray, decodeError)
        }.resume()
    }

    @objc
    func fillInDetails(for pokemon: Pokemon) {
        URLSession.shared.dataTask(with: pokemon.detailURL) { [weak self] data, response, error in
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

            var pokemonDict: [String: Any]?
            do {
                pokemonDict = try JSONSerialization
                    .jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                NSLog("Error decoding pokemon JSON: \(error)")
                return
            }

            // get id
            pokemon.idNumber = pokemonDict?["id"] as? NSNumber

            // get abilities
            var abilities: [String] = []
            if let abilitiesJSONArray = pokemonDict?["abilities"] as? [[String: Any]] {
                for abilityTopDict in abilitiesJSONArray {
                    let abilityLowerDict = abilityTopDict["ability"] as? [String: String]
                    if let abilityName = abilityLowerDict?["name"] {
                        abilities.append(abilityName)
                    }
                }
            }
            pokemon.abilities = abilities

            // get sprite url
            let sprites = pokemonDict?["sprites"] as? [String: String]
            let imageURLString = sprites?["front_default"]
            if let urlString = imageURLString,
                let imageURL = URL(string: urlString) {
                pokemon.spriteURL = imageURL
                self?.fetchSprite(for: pokemon, with: imageURL)
            }
        }.resume()
    }

    private func fetchSprite(for pokemon: Pokemon, with url: URL) {
        URLSession.shared.dataTask(with: pokemon.detailURL) { data, response, error in
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

            pokemon.sprite = UIImage(data: data)
        }.resume()
    }
}
