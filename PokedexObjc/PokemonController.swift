//
//  PokemonController.swift
//  PokedexObjc
//
//  Created by Kenneth Jones on 2/19/21.
//

import Foundation
import UIKit

@objcMembers
class PokemonController: NSObject {
    
    static let shared = PokemonController()

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    func fetchAll(completion: @escaping ([String]?, Error?) -> Void) {
        var pokemon: [String] = []
        
        var fetchComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        fetchComponents?.queryItems = [URLQueryItem(name: "limit", value: "1118")]
        let fetchURL = fetchComponents?.url
        
        var request = URLRequest(url: fetchURL!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                print("No data received from fetchAll")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let pokedex = dictionary["results"] as? [[String: String]] else {
                    print("Error decoding Pokemon data: \(error!)")
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                
                for poke in pokedex {
                    if let name = poke["name"] {
                        pokemon.append(name)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(pokemon, nil)
                }
            } catch {
                print("Error decoding Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }
        task.resume()
    }
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
        let searchURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            guard let data = data else {
                print("No data received from fetchPokemon")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                guard let pokemonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("Error decoding Pokemon data.")
                    return
                }
                let pokemon = Pokemon(dictionary: pokemonData)
                DispatchQueue.main.async {
                    completion(pokemon, nil)
                }
            } catch {
                print("Error decoding Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }
        task.resume()
    }
    
    private func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        getImageData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(UIImage(data: data)!, nil)
            }
        }
    }
}
