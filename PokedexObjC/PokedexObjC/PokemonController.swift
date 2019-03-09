//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Austin Cole on 3/8/19.
//  Copyright © 2019 Austin Cole. All rights reserved.
//

import UIKit

@objc
class PokemonController: NSObject {
    

    @objc
    var pokemon: ABCPokemon?
    
    @objc
    static let shared = PokemonController()
    
    
    @objc
    func fetchAllPokemon(completion: @escaping (_ pokemon: [ABCPokemon]?, _ error: Error?) -> Void) {
        let requestURL = URL(string:"https://pokeapi.co/api/v2/pokemon/")

        
        URLSession.shared.dataTask(with: requestURL!) { (data, _, error) in
            if let error = error {
                NSLog("Error performing data task.")
                completion(nil, error)
                return
            }
            guard data == data else {
                NSLog("Error getting data.")
                completion(nil, nil)
                return
            }
            var pokemonArray: [ABCPokemon] = []
            
            do {
                let pokemonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                let resultsArray = pokemonDictionary["results"] as! NSArray
                for index in 0 ... resultsArray.count - 1 {
                    let pokemon = ABCPokemon.init(nameAndUrlWith: resultsArray[index] as! [AnyHashable : Any])
                    pokemonArray.append(pokemon)
                    completion(pokemonArray, nil)
                }
            } catch {
                NSLog("Error decoding JSON.")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc
    func fillInDetails(for pokemon: ABCPokemon, from viewController: UIViewController) {
        let requestURL = URL(string: pokemon.url)
        
        URLSession.shared.dataTask(with: requestURL!) { (data, _, error) in
            if let error = error {
                NSLog("Error performing data task: \(error)")
                return
            }
            guard data == data else {
                NSLog("Error getting data.")
                return
            }
            do {
                let pokemonDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                pokemon.addObserver(viewController, forKeyPath: "idNumber", options: [], context: nil)
                pokemon.fillInDetails(with: pokemonDictionary as! [AnyHashable : Any])
                let existingIDNumber = pokemon.idNumber
                pokemon.idNumber = existingIDNumber
            } catch {
                NSLog("Error decoding JSON: \(error)")
                return
            }
        }.resume()
    }

}
