//
//  PokemonAPIController.swift
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

@objc(JGPPokemonAPIController)
class PokemonAPIController: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPIController()
    
    
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("error getting pokemon detail: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Data not returned from data task")
                completion(nil, error)
                return
            }
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                    let results = dictionary["results"] as? [[String : Any]]
                    else { throw NSError() /* TODO: enum for errors} */ }
                
                //print("dictionary is: \(dictionary)")
                
                let pokemons = results.compactMap({ Pokemon(dictionary: $0) })
                
                
                completion(pokemons, nil)
                
            } catch let decodingError {
                NSLog("Error decoding Pokemon detail from data: \(decodingError)")
                completion(nil, error)
            }
        }.resume()
    }

//UNCOMMENT WHEN READY TO FETCH DETAILS FOR POKEMON
    @objc func fillInDetails(for pokemon: Pokemon) {
        
        //let nameForDetails = pokemon.name
        let requestURL = baseURL.appendingPathComponent(pokemon.name)
        let request = URLRequest(url: requestURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("error getting pokemon detail: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Data not returned from data task")
                return
            }
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    else { throw NSError() /* TODO: enum for errors} */ }

                let pokemonDetail = Pokemon(dictionary: dictionary)
                
                print(pokemonDetail!.description)
                
            } catch let decodingError {
                NSLog("Error decoding Pokemon detail from data: \(decodingError)")
            }
        }.resume()
    }

 
}
