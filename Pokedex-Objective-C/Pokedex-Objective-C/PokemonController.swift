//
//  PokemonController.swift
//  Pokedex-Objective-C
//
//  Created by Alex Shillingford on 6/14/20.
//  Copyright © 2020 shillwil. All rights reserved.
//

import Foundation
class WASPokemonController: NSObject {
    @objc(sharedController) static let shared = WASPokemonController()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    @objc func fetchAllPokemon(completion: @escaping ([WASPokemon]?, Error?) -> Void) {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "100")]
        guard let fetchURL = urlComponents?.url else { return }
        
       let dataTask = URLSession.shared.dataTask(with: fetchURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, error)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                guard let results = json["results"] as? [[String: Any]] else { throw NSError() }
                let allPokemon = results.map({ WASPokemon(dictionary: $0) })
                completion(allPokemon, nil)
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return completion(nil, error)
            }
        }
        dataTask.resume()
    }
    
    @objc func fillInDetails(for pokemon: WASPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        //NSLog("Retrieving details for \(pokemon.name) with URL: \(url)")
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw NSError() }
                let detailPokemon = WASPokemon(dictionary: jsonDictionary)
                pokemon.name = detailPokemon.name
                pokemon.frontImage = detailPokemon.frontImage
                pokemon.identifier = detailPokemon.identifier
                pokemon.abilities = detailPokemon.abilities
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return
            }
        }
        dataTask.resume()
    }
}
