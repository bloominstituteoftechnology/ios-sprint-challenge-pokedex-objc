//
//  Network.swift
//  PokeDexOBJC
//
//  Created by Michael Flowers on 11/23/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

//Give this an OBJC name
@objc(MRFNetwork)

class Network: NSObject {
    
    //GET BASE URL
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    //make accessible to OBJC
    @objc static let shared = Network()
    @objc var pokemons: [MRFPokemon] = []
    @objc var detailsForPokemon: MRFPokemon?
    
    //get all the pokemons
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
                                print(" PokemonDictionary: \(pokemonDictionary)")
                
                //Results is a key who's value is an Array of dictionaries [[ String : Any ]]
                guard let results = pokemonDictionary["results"] as? [[String : Any]] else {
                    completion(nil, NSError())// TODO: HANDLE ERRORS
                    return
                }
                                print("Reuslts from PokemonDictionary: \(results)")
                
                //because results is an array of dictionaries we can loop through, and get a dictionary back, because we are getting a dictionary back we can call our MRFPokemon init with dictionary
                let returnedPokemons = results.compactMap { MRFPokemon(dictionary: $0)}
                self.pokemons = returnedPokemons
                completion(returnedPokemons, nil)
                
            } catch {
                print("Error serializing JSON: \(error)")
                completion(nil, error)
                return
            }
        }
        .resume()
    }
    
    //make accessible to objc - take one pokemon from that array and specifically fetch for it
    @objc func fillInDetails(for pokemon: MRFPokemon){
        //we need the pokemon to append the baseURL
        guard let url = URL(string: baseURL)?.appendingPathComponent(pokemon.name) else {
            print("Something wrong with url")
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                print("The response is: \(response.statusCode)")
            }
            
            if let error = error {
                print("Error in: \(#function)\n on line: \(#line)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
                return
            }
            
            guard let data = data else {
                print("Error unwrapping data in: \(#function) on line: \(#line)")
                return
            }
            
            do {
                //access the jsonDictionary
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("Error serializing jsonDictionary in; \(#function) on line: \(#line)")
                    return
                }

                //initailize our model object with the dictionary
                guard let pokemonInformation = MRFPokemon(dictionary: jsonDictionary) else {
                    print("Error initializing MRFPokemon in: \(#function) on line: \(#line)")
                    return
                }

                //take single pokemon and assign it to our holding pokemon up top
                self.detailsForPokemon = pokemonInformation


            } catch  {
                print("Error in: \(#function)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
            }
            
        }.resume()
    }
    
    //fetch the sprite from the pokemon we extracted from the pokemon array
    @objc func fetchSprite(with pokemon: MRFPokemon, completion: @escaping (UIImage?, Error?) -> Void){
        //construct the url to get image
        let url = URL(string: pokemon.sprite)!
        print("This is the sprite url: \(url.debugDescription)")
        
        //the default request is get so we don't have to do anything here just call urlsession
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse {
                         print("The response is: \(response.statusCode)")
            }
            
            if let error = error {
                print("Error in: \(#function)\n on line: \(#line)\n Readable Error: \(error.localizedDescription)\n Technical Error: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error unwrapping data in: \(#function) on line: \(#line)")
                completion(nil, NSError())
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Error initializing image with the returned data in: \(#function) on line: \(#line)")
                completion(nil, NSError())
                return
            }
            completion(image, nil)
        }.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
