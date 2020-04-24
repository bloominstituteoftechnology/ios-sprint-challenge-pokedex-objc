//
//  PokemonAPI.swift
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
     
    private let allPokemonURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!
    private let baseURLForFetchingPokemonDetail = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemons : [NPTPokemon] = []
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([NPTPokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: allPokemonURL) { [weak self ] (data, response, error) in
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
                guard let self = self else { return }
                guard let pokemon = NPTPokemon(dictionary: pokemonDict) else { return }
                self.pokemons.append(pokemon)
                completion(self.pokemons,nil)
            }
       
        }.resume()
    }
    
    
    

    @objc func fillInDetails(for pokemon: NPTPokemon) {
        let endpoint = baseURLForFetchingPokemonDetail.appendingPathComponent(pokemon.name)
        
        URLSession.shared.dataTask(with: endpoint) {  (data, response, error) in
          
            guard let data = data else { return }
            var topLevelDictionary : [String:Any]?
            do {
                topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            } catch let err as NSError {
                print(err)
                return 
            }
            // id
            guard let topLevelDict = topLevelDictionary else { return }
            guard let id = topLevelDict["id"] as? NSNumber else { return }
            pokemon.identifier  = id
            
            // image
            let spritesDictionary = topLevelDict["sprites"] as! [String:String?]
            let imageURLString = spritesDictionary["front_default"] as? String
            if let imageURL = URL(string: imageURLString!) {
                guard let data = try? Data(contentsOf: imageURL) else { return }
                pokemon.pokemonImage = UIImage(data: data)!
            }
            // abilities
            
            let abilitiesArray = topLevelDict["abilities"] as! [[String:Any]]
            for item in abilitiesArray {
                let ability = item["ability"] as! [String:String]
                let abi = ability["name"]!
                pokemon.abilities.append(abi)
            }
           
        }.resume()
        
    }
    
 
    
}
