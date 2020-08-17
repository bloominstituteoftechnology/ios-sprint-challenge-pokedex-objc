//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

import Foundation


class PokemonController: NSObject {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

    @objc(sharedController) static let shared = PokemonController()

    @objc func fetchAllPokemon(completion: @escaping ([SMAPokemon]?, Error?) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("error fetching all pokemon: \(error)")
                completion(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("bad response while fetching all pokemon: \(response)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from fetching all pokemon")
                completion(nil, nil)
                return
            }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String : Any] else {
                NSLog("error converting json to dictionary")
                completion(nil, nil)
                return
            }
            
            guard let resultsArray = dictionary["results"] as? Array<[String: String]> else {
                NSLog("error getting results array")
                completion(nil, nil)
                return
            }
            
            var allPokemon = [SMAPokemon]()
            for item in resultsArray {
                allPokemon.append(SMAPokemon(dictionary: item))
            }
            
            completion(allPokemon, nil)
            
        }.resume()
    }

    @objc func fillInDetails(for pokemon: SMAPokemon) {
        
    }
}
