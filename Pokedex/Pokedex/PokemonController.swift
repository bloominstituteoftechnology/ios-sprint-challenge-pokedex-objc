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
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any],
                      let abilites = jsonDict["abilities"] as? [[String:Any]],
                      let sprites = jsonDict["sprites"] as? [String:Any] else {throw NSError()}
                
                for ability in abilites {
                    guard let newAbility = ability["ability"] as? [String:Any] else {return}
                    let abilityName = newAbility["name"]
                    pokemon.abilities?.add(abilityName ?? "No abilities")
                }
                
                pokemon.id = jsonDict["id"] as? String
                pokemon.sprite = sprites["front_default"] as? String
            } catch {
                print("Error decoding pokemon details: \(error)")
                return
            }
        }
    }
}
