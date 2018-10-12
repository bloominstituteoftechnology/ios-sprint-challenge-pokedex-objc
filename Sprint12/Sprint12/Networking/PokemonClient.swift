//
//  PokemonClient.swift
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

@objcMembers
class PokemonAPI: NSObject {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // TODO: How do we use this shared instance?

//    @objc(sharedController) static let shared: PokemonAPI
    
    private var pokemons: [DODPokemon] = []
    
    @objc func fetchAllPokemon(completion: @escaping ([DODPokemon]?, Error?) -> Void) {
        
        let request = URLRequest(url: baseURL)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error decoding data: \(error)")
            }
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]
                
                // TODO: How do we return this?
                
                print(json as Any)
            } catch {
                NSLog("Error deserialziing JSON: \(error)")
            }
            
        }
        
    }
    
    @objc func fillInDetails(for pokemon: DODPokemon, name: String, identifier: String, sprite: String, abilities: String) {
        
        let pokemon = DODPokemon(name: name, identifier: identifier, sprite: sprite, abilities: abilities)
        pokemons.append(pokemon)
    }
    
}
