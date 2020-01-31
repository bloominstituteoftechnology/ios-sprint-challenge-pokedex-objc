//
//  PokemonAPI.swift
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    private(set) var pokemon: [Pokemon] = []

    private var baseURL: URL? = URL(string: "https://pokeapi.co/api/v2/")

    @objc(sharedController)
    static let shared = PokemonAPI()

    override private init() {}

    @objc
    func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let url = URL(fileURLWithPath: "pokemon/?limit=20000", relativeTo: baseURL)
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
                completion(nil, errorWithMessage("Error fetching Pokemon data; no data received", LSIAPIError.rawValue))
                return
            }

            do {
                let pokemonDict = try JSONSerialization
                    .jsonObject(with: data, options: []) as? Dictionary<String, Any>

                let results = pokemonDict?["results"]
                
            } catch {
                completion(nil, error)
                return
            }
        }
    }

    @objc
    func fillInDetails(for pokemon: Pokemon) {
        
    }
}
