//
//  PokemonController.swift
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class PokemonController: NSObject {
    @objc(sharedController) static let shared = PokemonController()
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([JACPokemon]?, Error?) -> Void) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "limit", value: "964")]
        
        guard let requestURL = components?.url else { completion(nil, NSError()); return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon from server: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from server")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                    completion(nil, NSError())
                    return
                }
                var pokemonArray = [JACPokemon]()
                for pokemon in pokemonDictionaries {
                    pokemonArray.append(JACPokemon(dictionary: pokemon))
                }
                
                completion(pokemonArray, nil)
            } catch {
                NSLog("Error decoding SearchResults from data on \(#line) in \(#file): \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: JACPokemon) {
        let url = URL(string: pokemon.url)!
        var request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error { return }
            guard let data = data else { return }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
                pokemon.fillInDetails(with: dictionary)
            } catch { return }
        }.resume()
        
        request = URLRequest(url: URL(string: pokemon.url)!)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error { return }
            guard let data = data else { return }
            pokemon.image = data
        }.resume()
    }
}
