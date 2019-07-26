//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Mitchell Budge on 7/26/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

@objc (MBPokemonController)
class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, NSError())
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                guard let results = jsonDictionary["results"] as? [[String: Any]] else { throw NSError() }
                let allPokemon = results.map({ Pokemon(dictionary: $0) })
                completion(allPokemon, nil)
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return completion(nil, NSError())
            }
        }
        dataTask.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                let detailPokemon = Pokemon(dictionary: jsonDictionary)
                pokemon.name = detailPokemon.name
                pokemon.sprite = detailPokemon.sprite
                pokemon.idNumber = detailPokemon.idNumber
                pokemon.abilities = detailPokemon.abilities
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return
            }
        }
        dataTask.resume()
    }
}
