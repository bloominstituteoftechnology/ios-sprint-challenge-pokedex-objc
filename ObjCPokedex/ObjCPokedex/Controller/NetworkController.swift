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
    
    /// Called in the DetailVC to fetch the rest of the details for the selected pokemon
    func fillInDetails(for pokemon: Pokemon) {
        
        let pokemonURL = URL(string: pokemon.url)!
        URLSession.shared.dataTask(with: pokemonURL) { (data, response, error) in
            if let error = error {
                print("Error fetching details for pokemon in fillInDetails() : \(error)")
            }
            if let response = response as? HTTPURLResponse {
                print("Response: \(response.statusCode)")
            }
            guard let data = data else {
                print("No data returned from fillInDetails() call")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                if let id = json["id"] as? Int {
                    pokemon.identifier = Int32(id)
                }
                if let sprites = json["sprites"] as? Dictionary<String, Any> {
                    if let sprite = sprites["front_default"] as? String {
                        pokemon.image = sprite
                    }
                }
                var abilitiesArray: [String] = []
                if let abilities = json["abilities"] as? [Dictionary<String, Any>] {
                    for ability in abilities {
                        if let ability = ability["ability"] as? Dictionary<String, Any> {
                            if let abilityASString = ability["name"] as? String {
                                abilitiesArray.append(abilityASString)
                            }
                        }
                    }
                }
                pokemon.abilities = abilitiesArray
            } catch {
                print("Error Decoding json in fillInDetails() : \(error)")
            }
        }.resume()
    }
    
    /// Called in the DetailVC to load the pokemon's image into the imageView
    func loadImage(urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        let imageURL = URL(string: urlString)!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error fetching image data: \(error)")
            }
            if let response = response as? HTTPURLResponse {
                print("Response: \(response.statusCode)")
            }
            guard let data = data else {
                print("No data was return from the image request")
                completion(nil, error)
                return
            }
            guard let image = UIImage(data: data) else {
                print("Failed to convert imageData -> UIImage")
                completion(nil, error)
                return
            }
            completion(image, nil)
        }.resume()
    }
    
}
