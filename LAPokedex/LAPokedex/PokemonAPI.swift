//
//  PokemonAPI.swift
//  LAPokedex
//
//  Created by Angel Buenrostro on 4/15/19.
//  Copyright © 2019 Angel Buenrostro. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    var pokemonArray: [LAPokemon] = []
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([LAPokemon]?, Error?) -> Void){
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error. No pokemon data returned.")
                completion(nil, error)
                return
            }
            
            do {
//                let decoder = JSONDecoder()
//                print(data)
//                let pokemon = try decoder.decode(Pokemon.self, from: data)
//                print("This is inside searchPokemon func: poke name is: \(poke.name)")
//                self.pokemon = poke
//                print("This is inside searchPokemon func: poke name is: \(self.pokemon!.name)")
//                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(nil, error)
                return
            }
            }.resume()
    
    }
    
    @objc func fillInDetails(for pokemon: LAPokemon){
        let queryTerm = pokemon.name
        let url = baseURL.appendingPathComponent(queryTerm)
        
        let request = URLRequest(url:url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("Error. No pokemon data returned.")
                return
            }
            
            do {
                
                //
               
            } catch {
                print("Error decoding received data: \(error)")
                return
            }
            }.resume()
    }
        // set pokemon's properties directly then use KVO to notify a UI update
    
}
