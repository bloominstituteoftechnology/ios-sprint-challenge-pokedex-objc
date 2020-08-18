//
//  NetworkController.swift
//  PokeDex-OBJC
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

import Foundation


let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

func fetchPokemon(completion: @escaping (Error) -> Void) {
    
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
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let pokemonData = json
            
        } catch {
            print("Hey Dude. Unable to decode into person search object: \(error)")
        }
        completion(error)
    }.resume()
    
}
