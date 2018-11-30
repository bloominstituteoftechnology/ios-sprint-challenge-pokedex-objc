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
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([IIIPokemon]?, Error?) -> Void) {
        var request = URLRequest(url: PokemonController.baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokedex: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                guard let results = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                    NSLog("Json object is not an NSDictionary")
                    completion(nil, NSError())
                    return
                }
                
                guard let pokedexDictionary = results["results"] as? NSArray else {
                    NSLog("Pokedex dictionary results is not an NSArray")
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
                NSLog("Unable encode json data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: IIIPokemon) {
        
    }
    
    @objc func fetchImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        
    }
}
