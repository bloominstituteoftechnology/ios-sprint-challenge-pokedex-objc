//
//  PokemonController.swift
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc var allPokemon: [Pokemon] = []
    
    private let baseURLString = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURLString) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Pokemon: \(error)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("No data returned.")
                return completion(nil, error)
            }
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let resultsDictionary = jsonDictionary["results"] as? [[String: String]] {
                        for pokemon in resultsDictionary {
                            let eachPokemon = Pokemon(dictionary: pokemon)
                            self.allPokemon.append(eachPokemon)
                        }
                        completion(self.allPokemon, nil)
                    }
                }
            } catch {
                NSLog("Error: Unable to decode Data \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Pokemon Info: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned")
                return
            }
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let id = jsonDictionary["id"] as? NSNumber {
                        pokemon.pokemonID = id
                    }
                    
                    if let abilitiesArray = jsonDictionary["abilities"] as? Array<[String: Any]> {
                        var someAbilities = ""
                        for ability in abilitiesArray {
                            let abilityDictionary = ability["ability"] as? [String: String]
                            guard let abilityName = abilityDictionary?["name"] else { return }
                            someAbilities.append(contentsOf: abilityName)
                        }
                        pokemon.pokemonAbilities = someAbilities
                    }
                    
                    if let sprites = jsonDictionary["sprites"] as? [String: Any] {
                        let imageURLString = sprites["front_shiny"] as? String
                        guard let imageURL = URL(string: imageURLString ?? "") else { return }
                        self.loadImage(url: imageURL) { (imageData) in
                            pokemon.sprite = imageData
                        }
                    }
                }
            } catch {
                NSLog("Error: Unable to decode Data \(error)")
                return
            }
        }.resume()
    }
    
    private func loadImage(url: URL, completion: @escaping (Data) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error loading image: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error with image data")
                return
            }
            completion(data)
        }.resume()
    }
}
