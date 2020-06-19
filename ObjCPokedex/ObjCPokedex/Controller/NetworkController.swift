//
//  NetworkController.swift
//  ObjCPokedex
//
//  Created by Shawn James on 6/19/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import UIKit

@objc(SDJNetworkController) class NetworkController: NSObject {
    
    var pokemon = [Pokemon]()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    /// Called to populate the table view with the names of the pokemon
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            if let error = error {
                print("Error fetching pokemon in fetchAllPokemon() : \(error)")
                completion(nil, error)
            }
            if let response = response as? HTTPURLResponse {
                print("Response: \(response.statusCode)")
            }
            guard let data = data else {
                print("No data returned from fetchAllPokemon() call")
                completion(nil, error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                if let results = json["results"] as? [Dictionary<String, String>] {
                    for result in results {
                        self.pokemon.append(Pokemon(name: result["name"]!, url: result["url"]!))
                    }
                }
            } catch {
                print("Error Decoding json in fetchAllPokemon() : \(error)")
                completion(nil, error)
            }
            completion(self.pokemon, nil)
        }.resume()
    }
    
}
