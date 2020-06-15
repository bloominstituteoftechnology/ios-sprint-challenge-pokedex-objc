//
//  PokemonController.swift
//  PokeDex-ObjC
//
//  Created by Christy Hicks on 6/14/20.
//  Copyright © 2020 Knight Night. All rights reserved.
//

import UIKit


@objc(CKPokemonController) class PokemonController: NSObject {
    
    private enum AnError: Error {
        case badResponse
        case badData
        case badDecode
    }
    
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: [Pokemon] = []
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                print("An error occured: \(error)")
                completion(nil, error)
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                    print("Server did not return a successful(200) response, try again.")
                    completion(nil, error)
            }
            
            guard let data = data else {
                print("No data")
                completion(nil, AnError.badData)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                
                if let array = json["results"] as? [Dictionary<String, String>] {
                    
                    for i in array {
                        let name = i["name"]
                        let url = i["url"]
                        let newPokemon = Pokemon(name: name!, url: url!)
                        self.pokemon.append(newPokemon)
                    }
                }
            } catch {
                print("Error Decoding json: \(error)")
                completion(nil, AnError.badData)
            }
            
            completion(self.pokemon, nil)
            
        }.resume()
    }
    
    @objc func fetchDetails(for pokemon: Pokemon) {
        let requestURL: URL = URL(string: pokemon.url)!
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                print("Error getting data: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("Did not get a successfull 200 response")
                return
            }
            
            guard let data = data else {
                print("No data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                
                if let id = json["id"] as? Int {
                    pokemon.identifier = Int32(id)
                }
                
                if let sprites = json["sprites"] as? Dictionary<String, Any> {
                    if let front_default = sprites["front_default"] as? String {
                        pokemon.image = front_default
                    }
                }
                
                var array: [String] = []
                
                if let abilitiesArray = json["abilities"] as? [Dictionary<String, Any>] {
                    for item in abilitiesArray {
                        if let ability = item["ability"] as? Dictionary<String, Any> {
                            if let name = ability["name"] as? String {
                                array.append(name)
                            }
                        }
                    }
                }
                
                pokemon.abilities = array
                
            } catch {
                print("Had an issue with json: \(error)")
            }
        }.resume()
    }
    
    @objc func fetchImage(at urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let imageUrl = URL(string: urlString)
        let request = URLRequest(url: imageUrl!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error getting image data: \(error)")
            }
            
            guard let data = data else {
                print("No data")
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Nonexistent or corrupt data")
                completion(nil, error)
                return
            }
            
            completion(image, nil)
            
        }.resume()
    }
}
