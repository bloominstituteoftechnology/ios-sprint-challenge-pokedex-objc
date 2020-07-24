//
//  PokedexController.swift
//  Pokedex Obj-C
//
//  Created by Nonye on 7/24/20.
//  Copyright © 2020 Nonye Ezekwo. All rights reserved.
//

import UIKit

class PokedexController: NSObject {
    
    private enum NetworkError: Error {
        case noData, noDecode, badURL, incompleteData, tryAgain
    }

    var pokemon: [Pokedex] = []
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!
    
    // MARK: - FETCH POKEMON
    @objc func fetchPokemon(completion: @escaping ([Pokedex]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving data: \(error)")
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Server did not recognize URL")
                completion(nil, NetworkError.badURL)
                return
            }
            
            guard let data = data else {
                NSLog("Server did not return Data")
                completion(nil, NetworkError.incompleteData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
                
                if let array = json["results"] as? [Dictionary<String,String>] {
                    for i in array {
                        let name = i["name"]
                        let url = i["url"]
                        let newPokemon = Pokedex(name: name!, url: url!)
                        self.pokemon.append(newPokemon)
                    }
                }
            } catch {
                NSLog("Failed to do something with json \(error)")
                completion(nil, NetworkError.tryAgain)
            }
            
            completion(self.pokemon, nil)
            
        }.resume()
    }
    
    
    // MARK: - FETCH POKEMON DETAILS/ABILITIES
    @objc func fillInDetails(for pokemon: Pokedex) {
        let requestURL: URL = URL(string: pokemon.url)!
        
        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving data for date: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Server did not return a good response")
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
                
                if let sprites = json["sprites"] as? Dictionary<String,Any> {
                    if let front_default = sprites["front_default"] as? String {
                        pokemon.image = front_default
                    }
                }
                var array: [String] = []
                
                if let abilitiesArray = json["abilities"] as? [Dictionary<String,Any>] {
                    for item in abilitiesArray {
                        if let ability = item["ability"] as? Dictionary<String,Any> {
                            if let name = ability["name"] as? String {
                                array.append(name)
                            }
                        }
                    }
                }
                pokemon.abilities = array
                
            } catch {
                NSLog("Failed grabbing information: \(error)")
            }
        }.resume()
    }
    
    // MARK: - FETCH IMAGE FUNCTION
    
    @objc func fetchImage(at urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let imageUrl = URL(string: urlString)
        let request = URLRequest(url: imageUrl!)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving pokemon image data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: data) else {
                NSLog("Image data is down.")
                completion(nil, error)
                return
            }
            
            completion(image,nil)
        }.resume()
    }
}
