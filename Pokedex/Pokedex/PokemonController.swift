//
//  PokemonController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 2/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

@objc class PokemonController: NSObject {
    
    //MARK: - Properties
    
    @objc(sharedController) static let shared = PokemonController()
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //MARK: - Methods
    
    @objc func fetchPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        var request = URLRequest(url: baseUrl)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let _ = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, error)
                return
            }

            do {
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let results = jsonDict["results"] as? [[String:Any]]  else {throw NSError()}
                let pokemon = results.compactMap {Pokemon(dictionary: $0)}
                completion(pokemon, nil)
            } catch {
                print("Error decoding pokemon names: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        let pokemonURL = URL(string: "\(pokemon.url)")!

        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                print("Error loading data: \(error)")
                return
            }

            guard let data = data else { return }

            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    if let pokemonID = dictionary["id"] as? NSNumber {
                        pokemon.id = "\(pokemonID)"
                    }
                    
                    if let abilities = dictionary["abilities"] as? [[String: Any]] {
                        for ability in abilities {
                            let abilityDictionary = ability["ability"] as? [String: String]
                            guard let name = abilityDictionary?["name"] else { return }
                            pokemon.abilities = name
                        }
                        
                    }
                    
                    if let sprites = dictionary["sprites"] as? [String: Any] {
                        let imageString = sprites["front_default"] as? String
                        guard let imageURL = URL(string: imageString ?? "") else { return }
                        self.loadImage(url: imageURL) { (data) in
                            pokemon.sprite = data
                        }
                    }
                }
            } catch {
                print("Error decoding pokemon details: \(error)")
                return
            }
        }.resume()
    }
    
    private func loadImage(url: URL, completion: @escaping (Data) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }

            guard let data = data else {
                print("Image data error")
                return
            }

            completion(data)
        }

        task.resume()
    }
}
