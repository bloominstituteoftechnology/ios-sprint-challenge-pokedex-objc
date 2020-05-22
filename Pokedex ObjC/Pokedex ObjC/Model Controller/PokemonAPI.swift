//
//  PokemonAPI.swift
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    private enum ServerErrors: Error {
        case badResponse
        case badData
        case errorDecoding
    }
    
    // MARK: - Properties
    @objc(sharedController) static let shared = PokemonAPI()
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: [WAHPokemon] = []
    
    @objc func fetchAllPokemon(completion: @escaping ([WAHPokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        print("REQUEST URL: \(requestURL)")
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving data for date: \(error)")
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Server did not return a success(200) URL response, try again.")
                completion(nil, ServerErrors.badResponse)
                return
            }
            
            guard let data = data else {
                NSLog("Server did not return good data")
                completion(nil, ServerErrors.badData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
                
                if let array = json["results"] as? [Dictionary<String,String>] {
                    for i in array {
                        let name = i["name"]
                        let url = i["url"]
                        let newPokemon = WAHPokemon(name: name!, url: url!)
                        self.pokemon.append(newPokemon)
                    }
                }
            } catch {
                NSLog("Failed to do something with json \(error)")
                completion(nil, ServerErrors.badData)
            }
            
            completion(self.pokemon, nil)
            
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: WAHPokemon) {
        let requestURL: URL = URL(string: pokemon.url)!
        print("REQUEST URL: \(requestURL)")
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving data for date: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Server did not return a success(200) URL response, try again.")
                return
            }
            
            guard let data = data else {
                NSLog("Server did not return good data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
                
                if let id = json["id"] as? Int {
                    pokemon.identifier = Int32(id)
                }
            } catch {
                NSLog("Failed to do something with json \(error)")
            }
            
        }.resume()
    }
}
