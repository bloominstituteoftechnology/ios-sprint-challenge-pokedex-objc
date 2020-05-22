//
//  PokeAPIClient.swift
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

typealias PokemonResultCompletion = (Result<[Pokemon], NetworkError>) -> Void
typealias ImageResultCompletion = (Result<UIImage, NetworkError>) -> Void

@objc class PokeApiClient: NSObject {
    
    @objc func fetchSortedPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        self.fetchAllPokemon { (result) in
            switch result {
            case .failure(let error):
                completion(nil, NSError(domain: error.localizedDescription, code: 0))
            case .success(let pokemon):
                completion(pokemon.sorted(by: { $0.name < $1.name }), nil)
            }
        }
    }
    
    func fetchAllPokemon(completion: @escaping PokemonResultCompletion) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "1000")
        ]
        
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            completion(PokemonResultDecoder().decode(result))
        }.resume()
    }
    
    func fillInDetails(for pokemon:Pokemon) {
        
    }
    
    func fetchImage(url: URL, completion: @escaping ImageResultCompletion) {
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { (result) in
            completion(ImageResultDecoder().decode(result))
        }.resume()
    }
    
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
