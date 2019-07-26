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
                    
                
                
                
                
                
//                let decoder = JSONDecoder()
//                let pokemon = try decoder.decode(Pokemon.self, from: data)
                
                // observe this!
                self.pokemon = pokemon
                
                
                
            } catch let decodingError {
                NSLog("Error decoding Pokemon detail from data: \(decodingError)")
                completion(nil, error)
            }
        }
             // .resume()
    }

//UNCOMMENT WHEN READY TO FETCH DETAILS FOR POKEMON
 /*   @objc func fillInDetails(for pokemon: Pokemon) {
        
        
        let requestURL = baseURL.appendingPathComponent(pokemon.name)
        
        // this time might need some queryItems to get (name again?) id, abilities, and sprite
        
        let urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: true)!
        
        //guard let this later, let's get something happening
        let request = URLRequest(url: urlComponents?.url)
        
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
                let pokemon = try JSONDecoder.decode(Pokemon.self, from: data)
                
                // observe this!
                self.pokemon = pokemon
                
                
                
            } catch let decodingError {
                NSLog("Error decoding Pokemon detail from data: \(decodingError)")
                completion(nil, error)
            }
        }.resume()
    }
 */
 
}
