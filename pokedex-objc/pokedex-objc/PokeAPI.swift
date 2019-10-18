//
//  PokeAPI.swift
//  pokedex-objc
//
//  Created by Bradley Yin on 10/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import Foundation
class PokemonAPI: NSObject {
    
    let baseURLString = "https://pokeapi.co/api/v2/pokemon"
    var nextURLString: String?

    @objc(sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([BYPokemon]?, Error?) -> Void) {
        var url = URL(string: baseURLString)
        if let nextURLString = nextURLString {
            url = URL(string: nextURLString)
        }
        
        guard let unwrappedURL = url else { return }
        
        URLSession.shared.dataTask(with: unwrappedURL) { (data, _, error) in
            if let error = error {
                print("error fetching all pokemon")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            do {
                guard let JSONDictionary = try JSONSerialization.jsonObject(with: data) as? NSDictionary else {
                    print("error converting to json dictionary")
                    completion(nil, NSError())
                    return
                }
                //print(JSONDictionary)
                self.nextURLString = JSONDictionary["next"] as? String
                var pokemons: [BYPokemon] = []
                if let pokemonDictionaries: Array = JSONDictionary["results"] as? Array<Dictionary<String, String>> {
                    for dictionary in pokemonDictionaries {
                        let pokemon = BYPokemon(dictionary: dictionary)
                        pokemons.append(pokemon)
                    }
                    completion(pokemons, nil)
                } else {
                    print("error converting results to array")
                    completion(nil, NSError())
                    return
                }
            } catch {
                print("error converting to json dictionary")
                completion(nil, NSError())
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: BYPokemon) {
        
        URLSession.shared.dataTask(with: pokemon.url) { (data, _, error) in
            if let error = error {
                print("error fetching pokemon detail")
                return
            }
            
            guard let data = data else {
                print("no detail data retun")
                return
            }
            do {
                guard let JSONDictionary = try JSONSerialization.jsonObject(with: data) as? NSDictionary else {
                    print("error converting to json dictionary")
                    return
                }
                print(JSONDictionary)
                if let id = JSONDictionary["id"] as? NSNumber {
                    pokemon.pokeId = id
                }
                
                if let abilitiesArray = JSONDictionary["abilities"] as? Array<Dictionary<String, Any>> {
                    var abilityString = ""
                    for ability in abilitiesArray {
                        let abilityDictionary = ability["ability"] as? Dictionary<String, String>
                        let abilityName = abilityDictionary?["name"]
                        abilityString.append(contentsOf: abilityName!)
                        abilityString.append(contentsOf: "\n ")
                    }
                    pokemon.abilities = abilityString
                    print(pokemon)
                }
                
                if let sprites = JSONDictionary["sprites"] as? Dictionary<String, Any> {
                    let imageURLString = sprites["front_default"] as? String
                    guard let imageURL = URL(string: imageURLString ?? "") else { return }
                    loadImage(url: imageURL) { (imageData) in
                        pokemon.imageData = imageData
                    }
                }

            } catch {
                print("error converting to json dictionary")
                return
            }
        }.resume()
    }
}


private func loadImage(url: URL, completion: @escaping (Data) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
            print("error loading image: \(error)")
            return
        }
        guard let data = data else {
            print("no image data returned")
            return
        }
        completion(data)
        
    }.resume()
}
