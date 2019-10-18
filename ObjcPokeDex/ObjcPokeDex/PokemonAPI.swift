//
//  PokemonAPI.swift
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        let request = URLRequest(url: requestURL)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching all pokemons: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("Error with fetch all pokemon data: \(String(describing: error))")
                completion(nil, error)
                return
            }
            do {
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let results = jsonDict["results"] as? [[String:Any]]  else {throw NSError()}
                let allPokemons = results.compactMap {LSIPokemon(dictionaryToGetNameAndURL: $0)}
                completion(allPokemons, nil)
            }catch {
                NSLog("Error decoding all pokemons: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: LSIPokemon) {
        
        let requestURL = URL(string: pokemon.pokeInfoURL)!
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching details for pokemon: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Error with pokemon detail data: \(String(describing: error))")
                return
            }
            do {
                guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any], let abilites = jsonDict["abilities"] as? [[String:Any]], let spriteDict = jsonDict["sprites"] as? [String:Any] else {throw NSError()}
                pokemon.abilites = NSMutableArray()
                for abilty in abilites {
                    guard  let innerAbility = abilty["ability"] as? [String:Any] else {return}
                    let abilityName = innerAbility["name"]
                    pokemon.abilites?.add(abilityName ?? "Ability is nil")
                }
                pokemon.id = NSNumber()
                pokemon.id = jsonDict["id"] as? NSNumber
                
                pokemon.spriteURLString = String()
                pokemon.spriteURLString = spriteDict["front_shiny"] as? String
                
            } catch {
                NSLog("Error decoding details for pokemon: \(error)")
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
