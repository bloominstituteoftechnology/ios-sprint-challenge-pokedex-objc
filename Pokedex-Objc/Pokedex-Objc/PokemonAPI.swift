//
//  PokemonAPI.swift
//  Pokedex-Objc
//
//  Created by Gi Pyo Kim on 12/20/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        
//    @objc(sharedController) static let shared: PokemonAPI
//
//    override init() {
//        PokemonAPI.shared = PokemonAPI()
//    }

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("PokemonAPI::fetchAllPokemon : Error while fetching all pokemon: \(error)")
                completion(nil, error);
                return
            }
            
            guard let data = data else {
                NSLog("PokemonAPI::fetchAllPokemon : No data was returned.")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    NSLog("PokemonAPI::fetchAllPokemon : Not able to get dictionary out of data.")
                    completion(nil, NSError())
                    return
                }
                
                guard let resultsArray = dictionary["results"] as? [[String : Any]] else {
                    NSLog("PokemonAPI::fetchAllPokemon : Not able to get results array.")
                    completion(nil, NSError())
                    return
                }
                
                var allPokemons:[Pokemon] = []
                for dict in resultsArray {
                    let pokemon = Pokemon.init(dictionary: dict)
                    if let pokemon = pokemon {
                        allPokemons.append(pokemon)
                    }
                }
                completion(allPokemons, nil)
            } catch {
                NSLog("PokemonAPI::fetchAllPokemon : Not able to get jsonObject from data: \(error)")
                completion(nil, error);
                return
            }
            
        }.resume()
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        let url = pokemon.detailURL
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("PokemonAPI::fillInDetails : Error while fetching details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("PokemonAPI::fillInDetails : No data was returned.")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    NSLog("PokemonAPI::fillInDetails : Not able to get dictionary out of data.")
                    return
                }
                
                pokemon.fillInDetails(for: pokemon, dictionary: dictionary)
                
            } catch {
                NSLog("PokemonAPI::fillInDetails : Not able to get jsonObject from data: \(error)")
                return
            }
            
        }.resume()
        
    }
}
