//
//  Network.swift
//  PokeDexObjc
//
//  Created by Michael Flowers on 7/26/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class Network: NSObject {
    static let shared = Network()
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    func fetchAllPokemon(completion: @escaping ([MRFPokemon]?, Error?) -> Void){
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
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String : Any] else {
                    print("Error with jsonDictionary")
                    completion(nil, NSError()) //TODO: ERROR HANDLING
                    return
                }

                guard let results = pokemonDictionary["results"] as? [[String : Any]] else {
                    completion(nil, NSError())// TODO: HANDLE ERRORS
                    return
                }
                
                //create a holder array to store temparily all of the pokemon we will get back from the pokemonDictionary
                var pokemonHolderArray = [MRFPokemon]()
                
                
                //use the dictionary to return an array of objects back
                for pokemon in results {
                    let returnedPokemon = MRFPokemon(dictionary: results)
                }
                
                
            } catch {
                print("Error serializing JSON: \(error)")
                completion(nil, error)
                return
            }
        }
    }
    
    func fillInDetails(for pokemon: MRFPokemon){
        //url this is going to take the name of the pokemon in the cell, put that name as a queryItem in the url and then make a network fetch for that specific pokemon
    }
}
