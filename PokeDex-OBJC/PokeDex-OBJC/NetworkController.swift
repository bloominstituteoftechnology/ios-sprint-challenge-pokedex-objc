//
//  NetworkController.swift
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

import Foundation

@objc class NetworkController: NSObject {
    let pokemonController = PokemonController()
    @objc var list: [String] = []
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

  @objc func fetchPokemon(completion: @escaping (Error) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error Parsing Data: \(error)")
                
                return
            }
            guard let data = data else {
                print("No Data returned from data task.")
                return
            }
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    guard let results = dictionary["results"] as? Array<Dictionary<String, String>> else { return }
                    for dictionary in results {
                        let namesDictionary = dictionary.filter { $0.key == "name"}
                        for values in namesDictionary.values {
                            self.list.append(values)
                            print(values)
                        }
                    }
                }
                
            } catch {
                print("Hey Dude. Unable to decode into person search object: \(error)")
            }
            
        }.resume()
    }
    
//    @objc func fillInDetails(for pokemon: String) {
//        let pokeURL = baseURL.appendingPathComponent(pokemon)
//        var request = URLRequest(url: pokeURL)
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            if let error = error {
//                print("Error Parsing Data: \(error)")
//                return
//            }
//
//            guard let data = data else {
//                print("No Data Returned")
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                pokemonController.pokemon = json as! Pokemon
//            } catch {
//                print("There was an error getting JSON data: \(error)")
//            }
//
//        }.resume()
//    }
    
    
}


