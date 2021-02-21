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
    enum NetworkError: Error {
        case noData, tryAgain, networkFailure
    }

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")! // <--!!!!
    
    func fetchAll(completion: @escaping (Result<[String], NetworkError>) -> Void) {
        var pokemon: [String] = []
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.tryAgain))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                DispatchQueue.main.async {
                    completion(.failure(.networkFailure))
                }
                return
            }
            
            guard let data = data else {
                print("No data received from fetchAll")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let pokedex = dictionary["results"] as? [[String: String]] else {
                    print("Error decoding Pokemon data: \(error!)")
                    DispatchQueue.main.async {
                        completion(.failure(.tryAgain))
                    }
                    return
                }
                
                for poke in pokedex {
                    if let name = poke["name"] {
                        pokemon.append(name)
                    }
                }
                
                DispatchQueue.main.async {
                    completion(.success(pokemon))
                }
            } catch {
                print("Error decoding Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.tryAgain))
                }
                return
            }
        }
        task.resume()
    }
    
    func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        let searchURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error receiving Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.tryAgain))
                }
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                DispatchQueue.main.async {
                    completion(.failure(.networkFailure))
                }
                return
            }
            
            guard let data = data else {
                print("No data received from fetchPokemon")
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            do {
                guard let pokemon = try JSONSerialization.jsonObject(with: data, options: []) as? Pokemon else {
                    print("Error decoding Pokemon data: \(error!)")
                    DispatchQueue.main.async {
                        completion(.failure(.tryAgain))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(pokemon))
                }
            } catch {
                print("Error decoding Pokemon data: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(.tryAgain))
                }
                return
            }
        }
        task.resume()
    }
    
    private func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        getImageData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.tryAgain))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(UIImage(data: data)!))
            }
        }
    }
}
