//
//  JDSPokemonController.swift
//  Pokedex_ObjC
//
//  Created by Lambda_School_Loaner_214 on 11/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

enum ControllerError: String, Error {
    case dataTaskError = "Error with DataTask"
    case noData = "No Data received"
    case jsonSerialization = "Error Serializing JSON"
    case mappingError = "Error mapping data"
}

class JDSPokemonController: NSObject {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc (sharedController) static let shared = JDSPokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([JDSPokemon]?, Error?) -> Void) {
       let dataTask = URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, ControllerError.dataTaskError)
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(nil, ControllerError.noData)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw ControllerError.jsonSerialization }
                guard let results = json["results"] as? [[String: Any]] else { throw ControllerError.mappingError }
                let allPokemon = results.map({ JDSPokemon(dictionary: $0) })
                completion(allPokemon, nil)
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return completion(nil, ControllerError.jsonSerialization)
            }
        }
        dataTask.resume()
    }
    
    @objc func fillInDetails(for pokemon: JDSPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else {
                NSLog("No data returned from data task")
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { throw ControllerError.jsonSerialization }
                let detailPokemon = JDSPokemon(dictionary: jsonDictionary)
                pokemon.name = detailPokemon.name
                pokemon.spriteURL = detailPokemon.spriteURL
                pokemon.idNumber = detailPokemon.idNumber
                pokemon.abilities = detailPokemon.abilities
            } catch {
                NSLog("Unable to serialize json data: \(error)")
                return
            }
        }
        dataTask.resume()
    }
}
