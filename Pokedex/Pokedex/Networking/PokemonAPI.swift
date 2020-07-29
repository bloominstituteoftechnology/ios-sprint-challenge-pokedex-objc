//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Jonathan Ferrer on 7/26/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//


import Foundation

@objc class PokemonAPI: NSObject {
    @objc static let shared: PokemonAPI = PokemonAPI()

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

    @objc func fetchAllPokemon(completion: @escaping ([JDFPokemon]?, Error?) -> Void) {

        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let limitQuery = URLQueryItem(name: "limit", value: "151")
        components.queryItems = [limitQuery]

        let requestURL = components.url!
        var pokemons: [JDFPokemon] = []

        let datatask = URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("No data was returned... ")
                completion(nil, nil)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = json["results"] as! [[String: String]]
                for result in results {
                    if let pokemon = JDFPokemon(dictionary: result) {
                        pokemons.append(pokemon)
                    }
                }
                completion(pokemons, nil)
            } catch {
                NSLog("Error decoding Pokemon: \(error)")
                completion(nil, error)
            }
        }
        datatask.resume()
    }

    @objc func fillInDetails(for pokemon: JDFPokemon) {

        let datatask = URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching details: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Error with data")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                pokemon.fillIn(with: json)

            } catch {
                NSLog("Error decoding Pokemon detail: \(error)")
            }
        }

        datatask.resume()
    }
}
