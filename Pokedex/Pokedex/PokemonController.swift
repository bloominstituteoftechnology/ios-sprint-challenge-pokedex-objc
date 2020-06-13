//
//  PokemonController.swift
//  Pokedex
//
//  Created by Enayatullah Naseri on 6/12/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import Foundation


@objc class PokemonController: NSObject {
    
    // MARK: - Base URL
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc var pokemon = [Pokemon]()
    
    
    // MARK: - Fetch Pokemon
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                
                print("No data returned.")
                return
            }
//            guard let array = dictionary["results"] as?
            
            do { // do - catch fetch
//                guard let dictionary = try?
                if let dictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
                    if let results = dictionary["results"] as? [[String: String]] {
                        for pokemon in results {
                            let fetchedPokemon = Pokemon(dictionary: pokemon)
                            self.pokemon.append(fetchedPokemon)
                        }
                        completion(self.pokemon, nil)
                    }
                }
                
            } catch {
                print("Error Decoding data: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    // MARK: - Pokemon fill in Detail
    @objc func fillInDetails(for pokemon: Pokemon) {
        
        let task = URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                print("Error getting data: \(error.localizedDescription)")
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
//                        var pokemonAbilities = [String]()
                        
                        for ability in abilities {
                            let abilityDictionary = ability["ability"] as? [String: String]
                            guard let name = abilityDictionary?["name"] else { return }
                            pokemonAbilities.append(contentsOf: name)
                        }
                        pokemon.pokemonAbilities = pokemonAbilities
                    }
//                        let dictionary = element["ability"] as? [String:String]
//                        guard let name = dictionary?["name"] else { continue }
                    
                    if let sprites = dictionary["sprites"] as? [String: Any] {
                        
                        let imageString = sprites["pokemon_sprites"] as? String
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
    
    // MARK: - Load Image
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
