//
//  PokemonController.swift
//  ObjcPokemon
//
//  Created by Diante Lewis-Jolley on 7/26/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import Foundation
import UIKit


class PokemonController: NSObject {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

    @objc static let shared = PokemonController()

    @objc func fetchPokemon(completion: @escaping ([DLJPokemon]?, Error?) -> Void) {

        let component = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let url = component.url!

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error getting data from URLSession: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, NSError())
                return
            }

            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }

                let resultDictionary = dictionary["results"] as? [[String: Any]]

                let pokemon = resultDictionary?.compactMap { DLJPokemon(dictionary: $0)}

                completion(pokemon, nil)

            } catch {
                completion(nil, error)
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: DLJPokemon) {

        let url = baseURL.appendingPathComponent(pokemon.name.lowercased())

        URLSession.shared.dataTask(with: url) { (data, _, error) in

            if let error = error {
                NSLog("Error getting details for pokemon: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Bad data")
                return
            }

            do {
                guard let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }

                let pokemonResults = DLJPokemon.init(dictionary: result)
                pokemon.name = pokemonResults.name
                pokemon.ablities = pokemonResults.ablities
                pokemon.pokemonID = pokemonResults.pokemonID
                pokemon.sprite = pokemonResults.sprite


            } catch {
                NSLog("Error fetching details for Pokemon")
            }
        }.resume()
    }








}

