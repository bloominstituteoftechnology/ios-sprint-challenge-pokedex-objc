//
//  PokemonAPI.swift
//  Pokedex-Hybrid
//
//  Created by Lambda_School_Loaner_204 on 1/30/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([SKSPokemon]?, Error?) -> Void) {

        var requestURL = URLRequest(url: baseURL)
        requestURL.httpMethod = "GET"

        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in

            if let error = error {
                print("Error fetching data!: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                print("Bad data!")
                completion(nil, NSError())
                return
            }
            
            do {
                if let pokemonAPI = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let pokemonResults = pokemonAPI["results"] as? Array<[String: Any]> {
                        for pokemon in pokemonResults {
                            print(pokemon);
                        }

                    }
                }
            } catch {
                print("Bad decoding!!")
                completion(nil, NSError())
            }

        }.resume()
    }

    @objc func fillInDetails(for pokemon: SKSPokemon) {

    }
}
