//
//  PokemonAPI.swift
//  POKEOBJCDEX
//
//  Created by Kelson Hartle on 8/16/20.
//  Copyright © 2020 Kelson Hartle. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
enum NetworkError: Error {
    case noData, failedSignUP, unableToCreateGig, failedSignIn, tryagain, noToken
}

@objc class PokemonAPI: NSObject {
    
    @objc var pokemonNames: [KRHPokemon] = []
    
    @objc dynamic var finished = false
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc(sharedController) static var shared: PokemonAPI {
        return PokemonAPI()
    }
    
    @objc func fetchAllPokemons(completion: @escaping ([KRHPokemon]?, Error?) -> Void) {
        
        finished = false;
        let requestURL = baseURL.appendingPathComponent("pokemon")
        print(requestURL)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error receiving pokemon data: \(error)")
                completion(nil, error)
                return
            }
            guard let data = data else {
                print("No data received from getPokemon")
                completion(nil, error)
                return
            }
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                let pokemon = PokemonResults.init(dictionary: jsonDictionary as! [String : Any])
                
                self.pokemonNames = pokemon.pokemon
                completion(self.pokemonNames,nil)
                print(self.pokemonNames)
                print(self.pokemonNames.first?.name ?? "")
                
            } catch {
                print("Error decoding pokemon data: \(error)")
                completion(nil, error)
            }
            
        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: KRHPokemon) {
        
        let pokemonPathComp = "pokemon"
        let pokeURL = baseURL.appendingPathComponent(pokemonPathComp)
        let requestURL = pokeURL.appendingPathComponent(pokemon.name)
        print(requestURL)
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                print("Error receiving pokemon data: \(error)")
                return
            }
            guard let data = data else {
                print("No data received from getPokemon")
                return
            }
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
                
                if let id = jsonDictionary["id"] as? Int {
                    pokemon.identifier = NSNumber(value: id)
                }
                if let sprites = jsonDictionary["sprites"] as? Dictionary<String,Any> {
                    if let sprite = sprites["front_default"] as? String {
                        guard let pokeURL = URL(string: sprite) else { return }
                        pokemon.image = pokeURL
                    }
                }
                
                var abilitiesArray: [String] = []
                if let abilities = jsonDictionary["abilities"] as? [Dictionary<String,Any>] {
                    for ability in abilities {
                        if let ability = ability["ability"] as? Dictionary<String,Any> {
                            if let name = ability["name"] as? String {
                                abilitiesArray.append(name)
                            }
                        }
                    }
                }
                pokemon.abilitiesArray = abilitiesArray
                
            } catch {
                print("Error decoding pokemon data: \(error)")
            }
            
            self.finished = true
        }.resume()
    }
}
