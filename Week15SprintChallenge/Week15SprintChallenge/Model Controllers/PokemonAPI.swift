//
//  PokemonAPI.swift
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    
    
    
    @objc func fetchAllPokemon(completion: @escaping ([DMOPokemon]?, Error?) -> Void) {

        let url = urlForFetch(searchTerm: "")
        
        print(url)
        
        
        
        
    }
    
    private func urlForFetch(searchTerm: String) -> URL {
        var url = baseURL
        if !searchTerm.isEmpty {
            url.appendPathComponent(searchTerm)
        } else {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let limitItem = URLQueryItem(name: "limit", value: "1000")
            components.queryItems = [limitItem]
            url = components.url!
        }
        return url
    }
    
}
