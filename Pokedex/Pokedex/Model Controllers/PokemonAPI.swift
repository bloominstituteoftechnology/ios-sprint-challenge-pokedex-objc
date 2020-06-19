//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Chris Dobek on 6/19/20.
//  Copyright © 2020 Chris Dobek. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc (sharedController) static let shared = PokemonAPI()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!
    
    @objc func fetchAllPokemon(completion: @escaping ([CMDPokemon]?, Error?) -> Void) {
        
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error { completion(nil, error); return }
            guard let data = data else { completion(nil, nil); return }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { completion(nil, nil); return }
            guard let array = dictionary["results"] as? Array<[String:String]> else { completion(nil, nil); return }
            var results = [CMDPokemon]()
            for item in array {
                results.append(CMDPokemon(dictionary: item))
            }
            completion(results, nil)
        }.resume()
    }
    
    @objc func getDetails(for pokemon: CMDPokemon) {
        
        guard let url = URL(string: pokemon.urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { return }
            let id = dictionary["id"] as? Int
            pokemon.identifier = String(id ?? 0)
            
            guard let abDict = dictionary["abilities"] as? [[String:Any]] else { return }
            var abilities = [String]()
            for element in abDict {
                let dict = element["ability"] as? [String:String]
                guard let name = dict?["name"] else { continue }
                abilities.append(name)
            }
            pokemon.abilities = abilities
            
            guard let spDict = dictionary["sprites"] as? [String:Any] else { return }
            pokemon.sprite = spDict["front_default"] as? String
            
            guard let typeArr = dictionary["types"] as? [[String:Any]] else { return }
            guard typeArr.count > 0 else { return }
            guard let type = typeArr[0]["type"] as? [String:String] else { return }
            pokemon.type = type["name"]
            
        }.resume()
    }
}

