//
//  PokemonController.swift
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import Foundation

class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        
        var urlComponents = URLComponents(url: allPokemonURL, resolvingAgainstBaseURL: false)
        let pokemonLimit = URLQueryItem(name: "limit", value: "1000")
        urlComponents?.queryItems = [pokemonLimit]
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                print("Error getting all pokemon data from Pokemon API")
                DispatchQueue.main.async {
                    completion(nil, NSError())
                }
                return
            }
            
            var pokemonArray = [Pokemon]()
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = jsonDictionary["results"] as? [Any] {
                        for item in results {
                            guard let pokemonDictionary = item as? [String: String] else { return }
                            let pokemon = Pokemon(dictionary: pokemonDictionary)
                            pokemonArray.append(pokemon)
                        }
                    }
                }
            } catch {
                print("Error parsing pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
            DispatchQueue.main.async {
                completion(pokemonArray, nil)
            }
            
        }.resume()
    }
}
