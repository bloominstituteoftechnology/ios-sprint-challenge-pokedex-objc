//
//  CDBPokemonController.swift
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

class CDBPokemonController: NSObject {
    
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    func fetchPokemons(completion: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                completion(error)
                return
                NSLog("Error: Data task")
            }
            
            guard let data = data else {
                completion(nil)
                return
                NSLog("Error: No data from data task")
            }
            
            do {
                let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                let resultsDict = try JSONSerialization.jsonObject(with: jsonDict, options: []) as? [String:Any]
            } catch {
                
            }
        }
    }
}
