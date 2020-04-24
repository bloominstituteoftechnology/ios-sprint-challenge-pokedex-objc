//
//  PokemonAPI.swift
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
     
    let allPokemonURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!
    var pokemons : [NPTPokemon] = []
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([NPTPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: allPokemonURL) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode < 200 || response.statusCode > 299 {
                completion(nil,errorWithMessage("bad response", LSIAPIError.rawValue))
                return
            }
            if let err = error as NSError? {
                completion(nil,err)
                return
            }
            guard let data = data else {
                completion(nil,errorWithMessage("No data", LSIPlaceError.rawValue))
                return
            }
            var topLevelDictionary : [String:Any?]
            do {
                topLevelDictionary = try (JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] ?? [:])
            } catch let error as NSError {
                completion(nil,error)
                return
            }
            guard let resultsArray = topLevelDictionary["results"] as? [[String:String]]else { return }
            
            for pokemonDict in resultsArray {
                guard let pokemon = NPTPokemon(dictionary: pokemonDict) else { return }
                self.pokemons.append(pokemon)
                completion(self.pokemons,nil)
            }
            
            
            
            
        }.resume()
    }
    
    
    

    @objc func fillInDetails(for pokemon: NPTPokemon) {
        
    }
    
    
    
    
    
    
    
    
    
    
}
