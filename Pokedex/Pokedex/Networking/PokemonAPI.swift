//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import UIKit

//private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=964")!
private var url = baseURL


class PokemonAPI: NSObject {
    
    // MARK: - Fetch list of Pokemon and link to detail
    
    @objc func fetchAllPokemon(completion: @escaping([SLRPokemon]?, Error?)-> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            // Check for error fetching list of Pokemon
            if let error = error {
                NSLog("Error fetching list of Pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            // Check for data
            guard let data = data else {
                NSLog("Pokèmon data error from API fetch \(String(describing: error))")
                completion(nil, error)
                return
            }
            
            // We have the list
            // Store pokemon list data in
            var pokemonList = [SLRPokemon]()
            
            // Let's populate the pokemonList with the names
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
               // let pokemonData = apiResponse.value(forKey: "results") as! NSArray
                guard let pokemonData = dictionary["results"] as? [[String: String]] else {return}

                for aPokemon in pokemonData {
                    pokemonList.append(SLRPokemon(dictionary: aPokemon))
                }
                
            // Had an error pulling out data
            } catch {
                NSLog("Unable to create Pokemon list \(error)")
                completion(nil, error)
                return
            }
            completion(pokemonList, nil)
            return
            
        } .resume()
    }
    
  
    //
    @objc func fillInDetails (for pokemon: SLRPokemon) {
        let url = URL(string: pokemon.detailLink!)!
        guard pokemon.sprite == nil else {return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error geting data: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Data not found")
                return
            }
            
            do{
                let dictionary = try JSONSerialization.jsonObject(with: data, options:[] ) as! [String: Any]
                
                if let theID = dictionary["id"] as? Int{
                    pokemon.pokemanID = String( theID)
                }
                
                if let abilitiesArray = dictionary["abilities"] as? [[String: Any]] {
                    pokemon.abilitiesArray(abilitiesArray)
                }
                if let spritesDict = dictionary["sprites"] as? [String:String?] {
                    let spriteURL = spritesDict["front_default"]
                    pokemon.sprite = spriteURL!
                }
            } catch {
                NSLog("Unable to retrieve sprites: \(error)" )
                return
            }
            }.resume()
    }
    
    



}
