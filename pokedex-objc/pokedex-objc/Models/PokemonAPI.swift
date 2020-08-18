//
//  PokemonAPI.swift
//  pokedex-objc
//
//  Created by conner on 8/14/20.
//  Copyright © 2020 conner. All rights reserved.
//

import Foundation

// https://pokeapi.co/api/v2/pokemon/?offset=0&limit=100 Add 20 to offset until 964
// {"count":964,"next":null,"previous":"https://pokeapi.co/api/v2/pokemon/?offset=930&limit=20","results":[IMPORTANT DATA]}
// GET https://pokeapi.co/api/v2/pokemon/<name>

@objc(PokemonAPI)
class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([XMPPokemon]?, Error?) -> Void) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=964")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Error encountered
            guard error == nil else {
                NSLog("Encounted error in fetchAllPokemon()")
                completion(nil, error)
                return
            }
            
            // No Data
            guard data != nil else {
                NSLog("No data received in fetchAllPokemon()")
                completion(nil, error)
                return
            }
            
            // Bad Response
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Bad response code in fetchAllPokemon()")
                completion(nil, error)
                return
            }
            
            // Successfully fetched all data, time to decode
            var pokemonArray: [XMPPokemon] = []
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                if let results = json["results"] as? [Dictionary<String, String>] {
                    for result in results {
                        pokemonArray.append(XMPPokemon(name: result["name"]!, url: result["url"]!))
                    }
                }
            } catch {
                print("Error Decoding json in fetchAllPokemon(): \(error)")
                completion(nil, error)
                return
            }
            completion(pokemonArray, nil)
        }.resume()
    }

    @objc func fillInDetails(for pokemon: XMPPokemon) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Error encountered
            guard error == nil else {
                NSLog("Encounted error in fillInDetails()")
                return
            }
            
            // No Data
            guard data != nil else {
                NSLog("No data received in fillInDetails()")
                return
            }
            
            // Bad Response
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Bad response code in fillInDetails()")
                return
            }
            
            // Successfully fetched all data, time to decode
            do {
                // Identifier
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! Dictionary<String, Any>
                if let id = json["id"] as? UInt {
                    pokemon.identifier = id
                }
                // ImageURL
                if let images = json["sprites"] as? Dictionary<String, Any> {
                    if let defaultImageURL = images["front_default"] as? String {
                        // load image into UIImage
                        self.loadImage(urlString: defaultImageURL, completion: { (image, error) in
                            guard error == nil else {
                                print("Error in fillInDetails:loadImage(): \(error!)")
                                return
                            }
                            guard let image = image else {
                                print("nil image in fillInDetails:loadImage()")
                                return
                            }
                            pokemon.image = image
                        })
                    }
                }
                // Abilities
                let abilitiesArray: NSMutableArray = []
                if let abilities = json["abilities"] as? [Dictionary<String, Any>] {
                    for ability in abilities {
                        if let ability = ability["ability"] as? Dictionary<String, Any> {
                            if let abilityName = ability["name"] as? String {
                                abilitiesArray.add(abilityName)
                            }
                        }
                    }
                }
                pokemon.abilities = abilitiesArray
            } catch {
                print("Error Decoding json in fillInDetails(): \(error)")
                return
            }
        }.resume()
    }
    
    @objc func loadImage(urlString: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let imageURL = URL(string: urlString)!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print("Error fetching data in loadImage(): \(error)")
            }
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Bad response code in loadImage()")
                return
            }
            guard let data = data else {
                print("No data fetched in loadImage()")
                completion(nil, error)
                return
            }
            guard let image = UIImage(data: data) else {
                print("Failed to convert data to Image in loadImage()")
                completion(nil, error)
                return
            }
            completion(image, nil)
        }.resume()
    }
}
