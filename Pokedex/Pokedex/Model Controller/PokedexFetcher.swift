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

            do {
//                let pokemon = try MTGPokemon.init(dictionary: data as [AnyHashable: Any])

                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {

                    // try to read out a string array
                    let pokemon = MTGPokemon.init(dictionary: json)

                    completion([pokemon], nil)
                }
            } catch let error as NSError {
                print("Error decoding: \(error.localizedDescription)")
                completion(nil, error)
            }

        }.resume()
    }

    @objc func fillInDetails(for pokemon: MTGPokemon) {

    }
}


