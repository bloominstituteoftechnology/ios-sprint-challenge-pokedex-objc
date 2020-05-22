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
    
    @objc func fetchDetails(for pokemon:Pokemon) {
        let request = URLRequest(url: baseURL.appendingPathComponent(pokemon.name))
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    guard let dict = try JSONSerialization
                        .jsonObject(with: data, options: .fragmentsAllowed) as? Dictionary<String, Any> else {
                        throw NetworkError.decodingError(NSError(domain: "⚠️ Error decoding pokemon details", code: 0))
                    }
                    self.fillInDetails(for: pokemon, with: dict)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fillInDetails(for pokemon: Pokemon, with dict:Dictionary<String, Any>) {
        if let identifier = dict["id"] as? Int32 {
            pokemon.identifier = identifier
        }
        
        if let spritesDict = dict["sprites"] as? Dictionary<String, String>,
           let urlString = spritesDict["front_default"] {
            pokemon.spriteURL = URL(string: urlString)
        }
        
        if let abilitiesContainer = dict["abilities"] as? Array<Dictionary<String, Any>> {
            let abilities = abilitiesContainer.map { (dict) -> String in
                let abilityDict = dict["ability"] as! Dictionary<String, String>
                return abilityDict["name"]!
            }
            pokemon.abilities = abilities
        }
    }
    
    func fetchImage(url: URL, completion: @escaping ImageResultCompletion) {
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { (result) in
            completion(ImageResultDecoder().decode(result))
        }.resume()
    }
}
