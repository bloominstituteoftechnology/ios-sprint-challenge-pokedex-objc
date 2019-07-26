//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Sameera Roussi on 7/26/19.
//  Copyright © 2019 Sameera Roussi. All rights reserved.
//

import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
private var url = baseURL


class PokemonAPI: NSObject {
    
    // MARK: - Fetch list of Pokemon and link to detail
    
    @objc func fetchListOfPokemon(completion: @escaping([SLRPokemon]?, Error?)-> Void) {
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            // Check for error fetching list of Pokemon
            if let error = error {
                NSLog("Error fetching list of Pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            // Check for data
            guard let data = data else {
                NSLog("Pokèmon data returned from API fetch \(String(describing: error))")
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
        
        
        
        
        
        
        
        
        
//        let apifetch = URLSession.shared.dataTask(with: url) { (data, _, error) in
//
//            // Check for error fetching list of Pokemon
//            if let error = error {
//                NSLog("Error fetching list of Pokemon: \(error)")
//                completion(nil, error)
//            }
//
//            // Check for data
//            guard let data = data else {
//                NSLog("Pokèmon data returned from API fetch \(error)")
//                completion(nil, error)
//            }
//
//            // We have the list
//            // Store pokemon list data in
//            var pokemonList: [SLRPokemon] = []
//
//            do {
//                let apiData = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//                let pokemonData = apiData.value(forKey: "apiData") as! NSArray
//
//                // Add the names to the pokemonList array
//                for pokeData in apiData {
//                    let aPokemon = SLRPokemon(dictionary: (pokeData as! NSDictionary) as! [String: Any])
//                    pokemonList.append(aPokemon)
//                }
//
//                completion(pokemonList, nil)
//                return
//
//            } catch {
//                NSLog("Unable to decode Pokemon list \(error)")
//                completion(nil, error)
//                return
//            }
//    } apiFetch.resume()
    
    
    
   // self.messageThreads = fetchedMessagesDict.map({$0.value})
    
  
    
}




