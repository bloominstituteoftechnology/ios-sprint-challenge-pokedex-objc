//
//  PokemonAPI.swift
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

import Foundation

@objc(CARPokemonAPI)
class PokemonAPI: NSObject {
    @objc(sharedController) static let shared =  PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2")?.appendingPathComponent("pokemon") else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [
            URLQueryItem(name: "limit", value: "20000")
        ]
        guard let url = urlComponents?.url else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "Pokemon-Objc-SprintChallenge", code: response.statusCode, userInfo: nil))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, NSError(domain: "Pokemon-Objc-SprintChallenge", code: 0, userInfo: nil))
                }
                return
            }
            
            var dict = [String : Any]()
            var pokemonArray = [Pokemon]()
            do {
                dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                let pokemonDictArray = dict["results"] as! [[String : String]]
                for pokemon in pokemonDictArray {
                    let pokemon = Pokemon(dictionary: pokemon)
                    if let pokemonToAppend = pokemon {
                        pokemonArray.append(pokemonToAppend)
                    }
                }
                DispatchQueue.main.async {
                    completion(pokemonArray, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        guard let name = pokemon.name else { return }
        guard let url = URL(string: "https://pokeapi.co/api/v2")?.appendingPathComponent("pokemon").appendingPathComponent("\(name)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                DispatchQueue.main.async {
                    var pokemonAbilities = [String]()
                    pokemon.pokemonId = dict["id"] as? NSNumber
                    let spriteDict = dict["sprites"] as! [String : Any]
                    pokemon.spriteURL = spriteDict["front_default"] as? String
                    let abilitiesArray = dict["abilities"] as! [[String : Any]]
                    for ability in abilitiesArray {
                        let abilityDict = ability["ability"] as? [String: Any]
                        let abilityName = abilityDict?["name"] as! String
                        pokemonAbilities.append(abilityName)
                    }
                    pokemon.abilities = pokemonAbilities
                }
            } catch {
              return
            }
        }.resume()
    }
}
