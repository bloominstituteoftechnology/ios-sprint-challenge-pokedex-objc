//
//  PokemonController.swift
//  Pokedex Objc Swift
//
//  Created by Ilgar Ilyasov on 11/30/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class PokemonController: NSObject {
    
    @objc(sharedController) static let shared: PokemonController = PokemonController()
    @objc private(set) var pokedex = [IIIPokemon]()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([IIIPokemon]?, Error?) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("fetchAllPokemon: Error fetching pokedex: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("fetchAllPokemon: No data returned from Url Session")
                completion(nil, NSError())
                return
            }
            
            do {
                guard let results = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    NSLog("fetchAllPokemon: Json object is not an NSDictionary")
                    completion(nil, NSError())
                    return
                }
                
                guard let pokedexDictionary = results["results"] as? NSArray else {
                    NSLog("fetchAllPokemon: Pokedex dictionary results is not an NSArray")
                    completion(nil, NSError())
                    return
                }
                
                var pokedex = [IIIPokemon]()
                for pokemonDictionary in pokedexDictionary {
                    let pokemon = IIIPokemon(pokemonWith: pokemonDictionary as! [AnyHashable : Any])
                    pokedex.append(pokemon)
                }
                
                DispatchQueue.main.async {
                    self.pokedex = pokedex
                    completion(pokedex, nil)
                }
            } catch {
                NSLog("fetchAllPokemon: Unable encode json data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: IIIPokemon) {
        var request = URLRequest(url: pokemon.pokemonURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("fillInDetails: Error fetching pokemon details: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("fillInDetails: No data returned from Url Session")
                return
            }
            
            do {
                guard let pokemonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any] else {
                    NSLog("fillInDetails: Json object is not an NSDictionary")
                    return
                }
                
                DispatchQueue.main.async {
                    pokemon.update(with: pokemonDictionary)
                }
            } catch {
                NSLog("fillInDetails: Unable encode json data: \(error)")
                return
            }
        }.resume()
    }
    
//    @objc func fetchPokemonImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//            if let error = error {
//                NSLog("fetchPokemonImage: Error fetching pokedex: \(error)")
//                completion(nil, error)
//                return
//            }
//            
//            guard let data = data else {
//                NSLog("fetchPokemonImage: No data returned from Url Session")
//                completion(nil, NSError())
//                return
//            }
//            
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                completion(image, nil)
//            }
//        }.resume()
//    }
}
