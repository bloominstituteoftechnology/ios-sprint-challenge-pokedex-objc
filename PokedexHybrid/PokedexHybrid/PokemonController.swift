//
//  PokemonController.swift
//  PokedexHybrid
//
//  Created by John Kouris on 2/22/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import Foundation

@objc class PokemonController: NSObject {
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc var allPokemon = [Pokemon]()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                print("Error occurred fetching pokemon: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data was returned.")
                return
            }
            
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let results = dictionary["results"] as? [[String: String]] {
                        for pokemon in results {
                            let fetchedPokemon = Pokemon(dictionary: pokemon)
                            self.allPokemon.append(fetchedPokemon)
                        }
                        completion(self.allPokemon, nil)
                    }
                }
            } catch {
                print("Unable to decode the pokemon data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        let task = URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                print("Error filling in pokemon details: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    if let pokemonID = dictionary["id"] as? NSNumber {
                        pokemon.pokemonID = pokemonID
                    }
                    
                    if let abilities = dictionary["abilities"] as? [[String: Any]] {
                        var pokemonAbilities = ""
                        for ability in abilities {
                            let abilityDictionary = ability["ability"] as? [String: String]
                            guard let name = abilityDictionary?["name"] else { return }
                            pokemonAbilities.append(contentsOf: name)
                        }
                        pokemon.pokemonAbilities = pokemonAbilities
                    }
                    
                    if let sprites = dictionary["sprites"] as? [String: Any] {
                        let imageString = sprites["front_shiny"] as? String
                        guard let imageURL = URL(string: imageString ?? "") else { return }
                        self.loadImage(url: imageURL) { (data) in
                            pokemon.sprite = data
                        }
                    }
                }
            } catch {
                print("Error decoding the pokemon data: \(error)")
                return
            }
        }
        
        task.resume()
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
