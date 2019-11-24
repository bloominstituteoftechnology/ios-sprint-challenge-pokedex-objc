//
//  Network.swift
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

//Give this an OBJC name
@objc(MRFNetwork)

class Network: NSObject {
    
    //GET BASE URL
     let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    //make accessible to OBJC
        @objc static let shared = Network()
        @objc var pokemons = [MRFPokemon]()
        
        @objc func fetchAllPokemon(completion: @escaping ([MRFPokemon]?, Error?) -> Void){
            //url - this is to populate the table view
            let url = URL(string: baseURL)!
            
            //no need to construct urlReqeust the default is get
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                print(url)
                
                if let response = response as? HTTPURLResponse {
                    print("The response is: \(response.statusCode)")
                }
                
                if let error = error {
                    print("Error fetching all pokemon: \(error.localizedDescription), a more DETAILEDERROR: \(error)")
                    completion(nil,error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, NSError()) //TODO: Error handling
                    return
                }
                
                //Because our model is in Objc it doesn't conform to codable so I have to use jsonserialization -Results is an array of dictionaries (pokemon)
                do {
                    //TOP level of the json is a dictionary that consists of string : any
                    guard let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String : Any] else {
                        print("Error with jsonDictionary")
                        completion(nil, NSError()) //TODO: ERROR HANDLING
                        return
                    }
    //                print(" PokemonDictionary: \(pokemonDictionary)")
                    
                    //Results is a key who's value is an Array of dictionaries [[ String : Any ]]
                    guard let results = pokemonDictionary["results"] as? [[String : Any]] else {
                        completion(nil, NSError())// TODO: HANDLE ERRORS
                        return
                    }
    //                print("Reuslts from PokemonDictionary: \(results)")
                    
                    //because results is an array of dictionaries we can loop through, and get a dictionary back, because we are getting a dictionary back we can call our MRFPokemon init with dictionary
                    let returnedPokemons = results.compactMap { MRFPokemon(dictionary: $0)}
                    completion(returnedPokemons, nil)
                    
                } catch {
                    print("Error serializing JSON: \(error)")
                    completion(nil, error)
                    return
                }
            }
            .resume()
        }
}
