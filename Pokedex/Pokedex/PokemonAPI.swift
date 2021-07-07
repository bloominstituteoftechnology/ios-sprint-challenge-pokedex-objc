//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Nikita Thomas on 2/1/19.
//  Copyright © 2019 Nikita Thomas. All rights reserved.
//

import Foundation
import UIKit

class PokemonAPI: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(pokemon) var pokemon = [PokemonAPI]()
    @objc(shared) static let shared = PokemonAPI()
    
    @objc func fetchPokemon(completion: @escaping ([NKTPokemon]?, Error?) -> Void) {
        
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                completion(nil, error)
            }
            
            guard let data = data else { completion(nil, error); return }
            
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                guard let pokemonDict = dict["results"] as? [[String: Any]] else { throw NSError() }
                
                let pokemon = pokemonDict.compactMap({ NKTPokemon(dictionary: $0) })
                completion(pokemon, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
            }
            }.resume()
    }
    
    
    @objc func fetchPokemonObject(pokemon: NKTPokemon) {
        
        let requestURL = URL(string: pokemon.detailURL)!
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching pokemon object: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                
                guard let pokemonID = dict["id"] as? Int else { throw NSError() }
                let spriteDict = dict["sprites"] as? [String: Any]
                guard let abilitiesDict = dict["abilities"] as? [[String: Any]] else { throw NSError() }
                
                guard let spriteURL = spriteDict?["front_default"] as? String else { throw NSError() }
                
                var abilities = [String]()
                
                for abilityDict in abilitiesDict {
                    let abilityName = abilityDict["ability"] as? [String: Any]
                    let ability = abilityName?["name"] as? String
                    abilities.append(ability ?? "")
                }
                
                pokemon.imageURL = spriteURL
                pokemon.pokemonID = pokemonID
                
                pokemon.abilities = abilities
            } catch {
                NSLog("Error converting dict to object: \(error)")
                return
            }
            }.resume()
        
    }
    
    
}
