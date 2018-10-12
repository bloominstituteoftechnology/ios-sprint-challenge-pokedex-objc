//
//  APIClient.swift
//  Pokedex
//
//  Created by Simon Elhoej Steinmejer on 12/10/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

@objc class SESPokemon: NSObject, Codable
{
    var pokemonurl: String
    var name: String
    
    init(pokemonurl: String, name: String)
    {
        self.pokemonurl = pokemonurl
        self.name = name
    }
}

class APIClient: NSObject
{
    @objc(sharedController) static let shared: APIClient = APIClient()
    
    @objc func fetchAllPokemon(completion: @escaping ([SESPokemon]?, Error?) -> Void)
    {
        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            
            if let error = error
            {
                NSLog("error fetching pokemons: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error unwrapping data")
                completion(nil, NSError())
                return
            }
            
            do {
                let pokemons = try JSONDecoder().decode(SESPokemon.self, from: data)
                completion([pokemons], nil)
            } catch {
                NSLog("Error decoding: \(error)")
                completion(nil, error)
                return
            }
        }
    }
    
    @objc func fillInDetails(for pokemon: SESPokemon)
    {
        
    }
    
}
