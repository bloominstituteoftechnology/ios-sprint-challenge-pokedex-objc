//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Andrew Dhan on 10/12/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

private let getURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([AELPokemon]?, Error?) -> Void){
        
        URLSession.shared.dataTask(with: getURL) { (data, _, error) in
            if let error = error {
                NSLog("Error getting Pokemon list: \(error)")
                completion(nil, error)
            }
            guard let data = data else {
                return
            }
            var pokeArray = [AELPokemon]()
            do{
                let dictionary = try JSONSerialization.jsonObject(with: data, options:[] ) as! [String: Any]
                
                guard let pokeDataArray = dictionary["results"] as? [[String: String]] else {return}
                
                for element in pokeDataArray {
                    pokeArray.append(AELPokemon(dictionary: element))
                }
            } catch {
                completion(nil, error)
            }
            completion(pokeArray,nil)
        }.resume()
        
        
    }
    
    @objc func fillInDetails(for pokemon: AELPokemon){
        let url = URL(string: pokemon.url)!
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error with dataTask: \(error)")
                return
            }
            guard let data = data else {
                return
            }
            
            do{
                let dictionary = try JSONSerialization.jsonObject(with: data, options:[] ) as! [String: Any]
                
                if let intID = dictionary["id"] as? Int{
                pokemon.id = String( intID)
                }
                
                guard let abilitiesArray = dictionary["abilities"] as? [[String: Any]] else {return}
                
                pokemon.loadAbilities(from: abilitiesArray)
                
                
            } catch {
                NSLog("Error filling details: \(error)" )
                return
            }
        }.resume()
    }
}
