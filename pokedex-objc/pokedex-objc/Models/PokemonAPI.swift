//
//  PokemonAPI.swift
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

import Foundation

// https://pokeapi.co/api/v2/pokemon/?offset=0&limit=100 Add 20 to offset until 964
// {"count":964,"next":null,"previous":"https://pokeapi.co/api/v2/pokemon/?offset=930&limit=20","results":[IMPORTANT DATA]}
// GET https://pokeapi.co/api/v2/pokemon/<name>

@objc(PokemonAPI)
class PokemonAPI: NSObject {
    var url: URL {
        URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=964")!
    }
    
    //@objc(sharedController) static let shared: PokemonAPI - No use for this right now
    @objc func fetchAllPokemon(completion: @escaping ([XMPPokemon]?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Error encountered
            guard error == nil else {
                NSLog("Encounted error in fetchAllPokemon()")
                completion(nil, error)
                return
            }
            
            // Bad Response
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Bad response code in fetchAllPokemon()")
                completion(nil, error)
                return
            }
            
            // No Data
            guard data != nil else {
                NSLog("No data received in fetchAllPokemon()")
                completion(nil, error)
                return
            }
            
            // Successfully fetched all data, time to decode
            var pokemonArray: [XMPPokemon] = []
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                if let results = json["results"] as? [Dictionary<String, String>] {
                    for result in results {
                        pokemonArray.append(XMPPokemon(name: result["name"]!, url: result["url"]!))
                    }
                }
            } catch {
                print("Error Decoding json in fetchAllPokemon(): \(error)")
                completion(nil, error)
                return
            }
            completion(pokemonArray, nil)
        }
        task.resume()
    }

    @objc func fillInDetails(for pokemon: XMPPokemon) {
        
    }
}
