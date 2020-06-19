//
//  PokemonController.swift
//  Pokedex
//
//  Created by Bhawnish Kumar on 6/19/20.
//  Copyright © 2020 Bhawnish Kumar. All rights reserved.
//

import UIKit



class PokemonController: NSObject {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    private enum NetworkError: Error {
           case badResponse
           case badData
           case errorDecoding
       }
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: [LSIPokemon] = []
    
    @objc(sharedController)
     static let shared = PokemonController()
    
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
                return
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
    
    @objc func fillInDetails(for pokemon: LSIPokemon) {
        let requestURL = URL(string: pokemon.detailURL)!
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
                  if let error = error {
                    NSLog("Error in getting details: \(error)")
                   return
                }
                
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    NSLog("Error in getting details response")
                    return
                }
                    
                guard let data = data else {
                     NSLog("Error in getting details data")
                    return
                }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
                if let id = json["id"] as? Int {
                    pokemon.identifier = Int32(id)
                }
                
                if let sprites = json["sprites"] as? Dictionary<String,Any> {
                    if let frontDefault = sprites["front_default"] as? String {
                        pokemon.image = frontDefault
                    }
                }
                
                var abilitiesArray: [String] = []
                
                if let abilities = json["abilities"] as? [Dictionary<String,Any>] {
                    for ability in abilities {
                        if let ability = ability["ability"] as? Dictionary<String,Any> {
                            if let name = ability["name"] as? String {
                                abilitiesArray.append(name)
                            }
                        }
                    }
                }
                pokemon.abilities = abilitiesArray
            } catch {
                NSLog("Error decoding json serialization: \(error)")
                
            }
        }
    .resume()
        
    }
    
    @objc func getImage(at urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
           let imageUrl = URL(string: urlString)
           let request = URLRequest(url: imageUrl!)
           
           URLSession.shared.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   NSLog("Error receiving pokemon image data: \(error)")
                   completion(nil, error)
                   return
               }
               
               guard let data = data else {
                   NSLog("GitHub responded with no image data") // Optional to print if you want
                   completion(nil, error)
                   return
               }
               
               guard let image = UIImage(data: data) else {
                   NSLog("Image data is incomplete or currupted.")
                   completion(nil, error)
                   return
               }
               
               completion(image,nil)
               
           }.resume()
       }

}
