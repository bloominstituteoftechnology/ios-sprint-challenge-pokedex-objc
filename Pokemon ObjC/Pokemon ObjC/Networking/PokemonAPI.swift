//
//  PokemonAPI.swift
//  Pokemon ObjC
//
//  Created by Lisa Sampson on 3/8/19.
//  Copyright © 2019 Lisa M Sampson. All rights reserved.
//

import Foundation

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared: PokemonAPI
    
    
    @objc func fetchAllPokemon(completion: @escaping ([LMSPokemon]?, Error?) -> Void) {
        
    }
    
    @objc func fillInDetails(for pokemon: LMSPokemon) {
        let url = baseURL.appendingPathComponent(pokemon.name)
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            print("Error")
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Data was not recieved.")
                return
            }
            
            
            
            }.resume()
    }
}
