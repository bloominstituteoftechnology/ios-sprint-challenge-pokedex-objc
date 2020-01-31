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
        
        fetch(from: url) { (dictionary, error) in
            
        }
        
        
        
        
    }
    
    private func fetch(from url: URL, using session: URLSession = URLSession.shared, completion: @escaping ([String: Any]?, Error?) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("error")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError())
                return
            }
            
            do {
                let possibleDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                
                guard let dictionary = possibleDictionary as? [String: Any] else {
                    print("JSON was not a dictionary")
                    completion(nil, NSError())
                    return
                }
                print(dictionary)
                completion(dictionary, nil)
                return
                
            } catch {
                
                print(error)
                completion(nil, error)
                return
                
            }
        }.resume()
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
