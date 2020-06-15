//
//  PokemonAPI.swift
//  SprintChallenge
//
//  Created by Joshua Rutkowski on 6/14/20.
//  Copyright © 2020 Ski. All rights reserved.
//

import Foundation
import UIKit

class PokemonAPI: NSObject {
    // MARK: -  Properties
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    @objc dynamic var pokemonImage: UIImage?
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc dynamic var pokemon: SKIPokemon?
    
    @objc func fetchAllPokemon(completion: @escaping ([SKIPokemon]?, Error?) -> Void) {

        let url = urlForFetch(searchTerm: "")
        
        fetch(from: url) { (dictionary, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let dictionary = dictionary else {
                completion(nil, NSError())
                return
            }
            guard let pokemonDictionaries = dictionary["results"] as? [[String: String]] else {
                print("Conversion to [[String: String]] failed.", dictionary["results"] ?? "no results")
                return
            }
            var pokemen: [SKIPokemon] = []
            for dictionary in pokemonDictionaries {
                if let pokemon = SKIPokemon(dictionary: dictionary) {
                    pokemen.append(pokemon)
                }
            }
            print(pokemen.count)
            completion(pokemen, nil)
        }
    }
    
    @objc func fetchAllDetails(for pokemon: SKIPokemon) {
        self.pokemon = nil
        guard let url = pokemon.infoURL else { return }
        
        fetch(from: url) { (dictionary, error) in
            if let error = error {
                print(error)
            }
            
            guard let dictionary = dictionary else {
                print("No dictionary.")
                return
            }
            
            let possibleFullPokemon = SKIPokemon(dictionary: dictionary)
            guard let fullPokemon = possibleFullPokemon else { return }
            
            self.pokemon = fullPokemon
        }
    }
    
    //MARK: - Private
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
                completion(dictionary, nil)
                return
                
            } catch {
                
                print(error)
                completion(nil, error)
                return
                
            }
        }.resume()
    }

}
