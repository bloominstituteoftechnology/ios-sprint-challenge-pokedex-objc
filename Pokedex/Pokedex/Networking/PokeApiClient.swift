//
//  PokeAPIClient.swift
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2")!

class PokeApiClient {
    
//    func fetchPokemon(withName name: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
//        var pokemonURL = baseURL.appendingPathComponent("pokemon")
//        pokemonURL.appendPathComponent(name.lowercased())
//
//        URLSession.shared.dataTask(with: pokemonURL) { (data, response, error) in
//            if let error = error {
//                NSLog("Error fetching pokemon: \(error)")
//                completion(.failure(.clientError(error)))
//                return
//            }
//
//            guard let data = data else {
//                NSLog("No data when trying to fetch pokemon")
//                completion(.failure(.noData))
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            do {
//                let pokemon = try decoder.decode(Pokemon.self, from: data)
//                completion(.success(pokemon))
//            } catch {
//                NSLog("Unable to decode JSON into pokemon: \(error)")
//                completion(.failure(.badData))
//            }
//        }.resume()
//    }
//
//    func fetchImage(for urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
//        guard let imageUrl = URL(string: urlString) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
//            if let error = error {
//                NSLog("Error fetching image: \(error)")
//                completion(.failure(.clientError(error)))
//                return
//            }
//
//            guard let data = data else {
//                NSLog("No data when trying to fetch image")
//                completion(.failure(.noData))
//                return
//            }
//
//            if let image = UIImage(data: data) {
//                completion(.success(image))
//            } else {
//                NSLog("Unable to produce image from data")
//                completion(.failure(.badData))
//            }
//        }.resume()
//    }
}
