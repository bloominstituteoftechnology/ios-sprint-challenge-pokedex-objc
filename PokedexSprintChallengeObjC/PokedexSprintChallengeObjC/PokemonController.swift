//
//  PokemonController.swift
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import Foundation

class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping (NSMutableArray?, Error?) -> Void) {
        let allPokemonURL = baseURL.appendingPathComponent("pokemon")
        
        var urlComponents = URLComponents(url: allPokemonURL, resolvingAgainstBaseURL: false)
        let pokemonLimit = URLQueryItem(name: "limit", value: "1000")
        urlComponents?.queryItems = [pokemonLimit]
        guard let requestURL = urlComponents?.url else { return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                print("Error getting all pokemon data from Pokemon API")
                DispatchQueue.main.async {
                    completion(nil, NSError())
                }
                return
            }
            
            let pokemonArray = NSMutableArray()
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = jsonDictionary["results"] as? [Any] {
                        for item in results {
                            guard let pokemonDictionary = item as? [String: String] else { return }
                            let pokemon = Pokemon(dictionary: pokemonDictionary)
                            pokemonArray.add(pokemon)
                        }
                    }
                }
            } catch {
                print("Error parsing pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
            DispatchQueue.main.async {
                completion(pokemonArray, nil)
            }
            
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        if pokemon.abilities == nil, pokemon.identifier == nil, pokemon.spriteImg == nil {
            let allPokemonURL = baseURL.appendingPathComponent("pokemon")
            let singlePokemonURL = allPokemonURL.appendingPathComponent(pokemon.name.lowercased())
            
            var request = URLRequest(url: singlePokemonURL)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let error = error {
                    print("Error fetching single pokemon: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("Error getting data for \(pokemon.name)")
                    return
                }
                
                do {
                    if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let sprites = jsonDictionary["sprites"] as? [String: Any] {
                            if let spriteURLString = sprites["front_default"] as? String {
                                self.getSpriteImage(with: spriteURLString) { (data, error) in
                                    if let error = error {
                                        print("The getSpriteImage data task failed with error: \(error)")
                                        return
                                    }
                                    guard let data = data else {
                                        print("Error getting sprite image data")
                                        return
                                    }
                                    pokemon.setValue(data, forKey: "spriteImg")
                                }
                            }
                        }
                        
                        if let identifier = jsonDictionary["id"] as? NSNumber  {
                            pokemon.setValue(identifier, forKey: "identifier")
                        }
                        
                        guard let allAbilities = jsonDictionary["abilities"] as? [Any] else { return }
                        var abilties: [String] = []
                        for item in allAbilities {
                            guard let abilityDict = item as? [String: Any], let ability = abilityDict["ability"] as? [String: String] else { return }
                            if let abilityName = ability["name"] {
                                abilties.append(abilityName)
                            }
                        }
                        if !allAbilities.isEmpty {
                            pokemon.setValue(abilties, forKey: "abilities")
                        }
                        
                    }
                } catch {
                    print("Error parsing data for pokemon")
                    return
                }
            }.resume()
        }
    }
    
    private func getSpriteImage(with urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error converting sprite image string to url.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error with data task when fetching sprite image: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("No data returned for sprite image")
                completion(nil, NSError())
                return
            }
            
            completion(data, nil)
        }.resume()
    }
    
    @objc func getAllPokemonByType(completion: @escaping (NSMutableArray?, Error?) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let dispatchGroup = DispatchGroup()
            let typesURL = self.baseURL.appendingPathComponent("type")
            let pokemonWithTypes = NSMutableArray()
            
            var typeID = 1
            for _ in 1...18 {
                let url = typesURL.appendingPathComponent("\(typeID)")
                
                dispatchGroup.enter()
                
                self.fetchPokemonForType(typeURL: url) { (type, pokemonArray, error) in
                    if let error = error {
                        print("Error getting pokemon types: \(error)")
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                        return
                    }
                    
                    if let type = type, let pokemonArray = pokemonArray as? [Pokemon] {
                        for pokemon in pokemonArray {
                            pokemon.type = type
                            pokemonWithTypes.add(pokemon)
                        }
                    }
                    
                    dispatchGroup.leave()
                }
                typeID += 1
            }
            
            dispatchGroup.wait()

            DispatchQueue.main.async {
                completion(pokemonWithTypes, nil)
            }
        }
    }
    
    
    @objc func fetchPokemonForType(typeURL: URL, completion: @escaping (String?, NSMutableArray?, Error?) -> Void) {
        var request = URLRequest(url: typeURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion(nil, nil, error)
                }
                return
            }
            
            guard let data = data else {
                print("Error getting all pokemon data from Pokemon API")
                DispatchQueue.main.async {
                    completion(nil, nil, NSError())
                }
                return
            }
            
            let pokemonArray = NSMutableArray()
            var typeName = String()
            
            
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let type = jsonDictionary["name"] as? String {
                        typeName = type
                        
                        if let pokemonResults = jsonDictionary["pokemon"] as? [Any] {
                            for item in pokemonResults {
                                guard let pokemonDictionary = item as? [String: Any] else { return }
                                if let slot = pokemonDictionary["slot"] as? Int {
                                    if slot == 1 {
                                        if let pokemonDetailDict = pokemonDictionary["pokemon"] as? [String: String] {
                                            let pokemon = Pokemon(dictionary: pokemonDetailDict)
                                            pokemonArray.add(pokemon)
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error parsing pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, nil, error)
                }
            }
            
            DispatchQueue.main.async {
                completion(typeName, pokemonArray, nil)
            }
            
        }.resume()
    }
    
}
