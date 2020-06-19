//
//  PokemonController.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 6/19/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class PokemonController {
    
    private enum NetworkError: Error {
           case badResponse
           case badData
           case errorDecoding
       }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: [LSIPokemon] = []
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon/")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Error in getting pokemon: \(error)")
                completion(nil, NetworkError.errorDecoding)
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Error in getting pokemon response")
                completion(nil, NetworkError.badResponse)
            }
                
            guard let data = data else {
                 NSLog("Error in getting pokemon data")
                completion(nil, NetworkError.badData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
                
                if let array = json["results"] as? [Dictionary<String,String>] {
                    for i in array {
                        let name = i["name"]
                        let url = i["url"]
                        let pokemon = LSIPokemon(name: name!, detailURL: url!)
                        self.pokemon.append(pokemon)
                    }
                }
                
            } catch {
                NSLog("Error in getting the json: \(error)")
                completion(nil, NetworkError.errorDecoding)
            }
            
            completion(self.pokemon, nil)
        }
    .resume()
        
    }


}
