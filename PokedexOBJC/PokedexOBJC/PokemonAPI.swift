//
//  PokemonAPI.swift
//  PokedexOBJC
//
//  Created by denis cedeno on 6/12/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

@objc
class PokemonAPI: NSObject {
    
    @objc var pokemonArray: [DSCPokemon] = []
    var pokemonAbilities: [String] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964")!
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    func addPokemon(pokemon: DSCPokemon) {
        pokemonArray.append(pokemon)
    }
    
    // MARK: FetchPokemon
    @objc func fetchAllPokemon(completion: @escaping ([DSCPokemon]?, Error?) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                completion(nil, error)
                return
            }
            
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let results = dictionary["results"] as? [[String:String]] {
                        for pokemon in results {
                            let pokemonObject = DSCPokemon(dictionary: pokemon)
                            self.addPokemon(pokemon: pokemonObject)
                        }
                    }
                }
                completion(self.pokemonArray, nil)
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    
    //MARK: Fill in Details
    @objc func fillInDetails(for pokemon: DSCPokemon) {
        
        let url = pokemon.pokemonURL
        guard let baseURL = URL(string: url) else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data returned from data task.")
                return
            }
            
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                    if let abilities = dictionary["abilities"] as? [[String:Any]],
                        let id = dictionary["id"] as? Int,
                        let sprites = dictionary["sprites"] as? [String:Any],
                        let frontSprite = sprites["front_default"] {
                        
                        pokemon.spriteURL = (frontSprite as? String)!
                        pokemon.pokemonID = "\(id)"
                        pokemon.getAbilityArray(abilities)
                        
                        self.fetchImage(from: pokemon.spriteURL) { image in
                            pokemon.pokemonSprite = image!
                        }
                        
                    }
                }
            } catch {
                print("Unable to decode data into object of type [Pokemon]: \(error)")
            }
        }.resume()
    }
    
    
    // MARK: Fetch Sprite
    @objc func fetchImage(from imageURL: String, completion: @escaping(UIImage?) -> Void) {
        
        guard let imageURL = URL(string: imageURL) else {
            completion(nil)
            return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (imageData, _, error) in
            
            if let error = error {
                NSLog("Error fetching image: \(error)")
                return
            }
            
            guard let data = imageData else {
                NSLog("No data provided for image: \(imageURL)")
                completion(nil)
                return
            }
            
            let image = UIImage(data: data)
            
            completion(image)
        }.resume()
    }
}

