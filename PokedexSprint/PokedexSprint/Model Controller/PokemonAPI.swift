//
//  PokemonAPI.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {

    // TODO: this is yelling at me
    @objc (sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([JLAPokemon]?, Error?) -> Void) {
        
        print("fetchAllPokemon")
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
                
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                print("no data")
                return
            }
            
            /*
             error = nil;
             NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
             
             if (error) {
                 NSLog(@"Error decoding JSON from data: %@", error);
                 completion(nil);
                 return;
             }
             
             if(!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
                 NSLog(@"Error: Expected top level dictionary in JSON result: %@", error);
                 completion(nil);
                 return;
             }
             
             NSLog(@"Dictionary: %@", dictionary);
             
            */
            
            /*
             {
             "count": 964,
             "next": "https://pokeapi.co/api/v2/pokemon/?offset=20&limit=20",
             "previous": null,
             "results": [
               {
                 "name": "bulbasaur",
                 "url": "https://pokeapi.co/api/v2/pokemon/1/"
               },
               {
                 "name": "ivysaur",
                 "url": "https://pokeapi.co/api/v2/pokemon/2/"
               },
             */
                    
            // NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let results = dictionary["results"] as! [[String: Any]] // array of array of dictionaries
                //self.pokemonArray.append(decodedPokemon)
                print("dictionary: \(dictionary)")
                print("results: \(results)")
                let pokemonResults = results.map {JLAPokemon(dictionary: $0)}
                print("pokemonResults: \(pokemonResults)")
                completion(pokemonResults, nil) //
            } catch {
                print("DECODE error: \(error)")
                completion(nil, NSError())
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: JLAPokemon) {
        
        print("fillInDetails")
        
        var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        baseURL = baseURL.appendingPathComponent(pokemon.name)
                
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            guard let data = data else {
                print("no data")
                return
            }
            
            // NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let fetchedPokemon = JLAPokemon(dictionary: dictionary)
                print("dictionary: \(dictionary)")
                
                pokemon.name = fetchedPokemon.name
                pokemon.identifier = fetchedPokemon.identifier
                pokemon.sprite = fetchedPokemon.sprite
                pokemon.abilities = fetchedPokemon.abilities
                
                print("pokemon now: \(pokemon.name), \(pokemon.identifier), \(pokemon.abilities), \(pokemon.sprite)")
                
            } catch {
                print("DECODE error: \(error)")
                return
            }
        }.resume()
    }
}
