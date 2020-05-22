//
//  Networking.swift
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import Foundation

@objc(LYDNetworking)
class Networking: NSObject {
    
    @objc func fetchPoke(completion: @escaping ([LYDPokemon]?, Error?) -> Void) {
        guard let baseURL = URL(string: "https://pokeapi.co/api/v2")?.appendingPathComponent("pokemon") else { return }
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        components?.queryItems = [
            URLQueryItem(name: "limit", value: "10000")
        ]
        guard let url = components?.url else { return }
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
                    NSLog("Data error fetching poke.")
                    completion(nil, NSError(domain: "Pokemon-Objc-SprintChallenge", code: 0, userInfo: nil))
                }
                return
            }

            var dictionary = [String : Any]()
            var pokeArray = [LYDPokemon]()
            do {
                dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                let result = dictionary["results"] as! [[String : String]]
                for pokemon in result {
                    let poke = LYDPokemon(dic: pokemon)
                    if let newPoke = poke {
                        pokeArray.append(newPoke)
                    }
                }
                DispatchQueue.main.async {
                    completion(pokeArray, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }.resume()
    }

    @objc func fetchDetails(for pokemon: LYDPokemon) {
        guard let name = pokemon.name else { return }
        guard let url = URL(string: "https://pokeapi.co/api/v2")?.appendingPathComponent("pokemon").appendingPathComponent("\(name)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                DispatchQueue.main.async {
                    var abilities = [String]()
                    pokemon.identifier = dictionary["id"] as? NSNumber
                    let imageDictionary = dictionary["sprites"] as! [String : Any]
                    pokemon.imageURLStr = imageDictionary["front_default"] as? String
                    let abilitiesArray = dictionary["abilities"] as! [[String : Any]]
                    for ability in abilitiesArray {
                        let abilityDictionary = ability["ability"] as? [String: Any]
                        let abilityName = abilityDictionary?["name"] as! String
                        abilities.append(abilityName)
                    }
                    pokemon.abilities = abilities
                }
            } catch {
              return
            }
        }.resume()
    }
}
