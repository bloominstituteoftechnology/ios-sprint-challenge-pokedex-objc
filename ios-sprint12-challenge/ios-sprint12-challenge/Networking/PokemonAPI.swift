//
//  PokemonAPI.swift
//  ios-sprint12-challenge
//
//  Created by De MicheliStefano on 12.10.18.
//  Copyright © 2018 De MicheliStefano. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    var baseUrl: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var pokemonsList = [String : (String, Pokemon)]()
    @objc var pokemons = [Pokemon]()
    @objc static let shared = PokemonAPI()
    
     @objc func fillInDetails(for pokemon: Pokemon) {
        let name = pokemon.name
        var url = baseUrl
        url.appendPathComponent(name)
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Could not fetch data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Could not get data")
                return
            }
            
            let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [])
            guard let pokemon = jsonDict as? [String : Any] else { return }
            
            if let name = pokemon["name"] as? String,
                let identifer = pokemon["id"] as? Int,
                let sprites = pokemon["sprites"] as? [String : Any],
                let abilitiesDicts = pokemon["abilities"] as? [[String : Any]] {
                
                guard let sprite = sprites["front_default"] as? String else { return }
                let abilities = abilitiesDicts.compactMap({ (abilitiesDict) -> String? in
                    if let ability = abilitiesDict["ability"] as? [String : Any],
                        let abilityName = ability["name"] as? String {
                        return abilityName
                    }
                    return nil
                })
                
                if let pokemonDict = self.pokemonsList[name] {
                    let retrievedPokemon = pokemonDict.1
                    if retrievedPokemon.identifier == nil {
                        retrievedPokemon.sprite = sprite
                        retrievedPokemon.abilities = abilities
                        retrievedPokemon.identifier = String(identifer)
                    }
                }
                
            }
            
        }.resume()
    }
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseUrl) { (data, _, error) in
            if let error = error {
                NSLog("Could not fetch data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Could not get data")
                completion(nil, NSError())
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [String : Any] else { return }
            
            if let pokemonList = jsonDict["results"] as? [[String : Any]] {
                for pokemon in pokemonList {
                    guard let name = pokemon["name"] as? String else { continue }
                    guard let url = pokemon["url"] as? String else { continue }
                    let pokemon = Pokemon(name: name)
                    self.pokemonsList[name] = (url, pokemon)
                }
            }
            
            self.pokemons = self.pokemonsList.map { $0.value.1 }
            
            completion(self.pokemons, nil)
            
        }.resume()
    }
    
}
