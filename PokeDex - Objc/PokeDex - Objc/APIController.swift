//
//  APIController.swift
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case badData
    case badRequest
    case otherError
    case noURL
    case noDecode
}

class APIController: NSObject {
    
    @objc(sharedController) static let shared = APIController()
    var pokemon: Pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let url = baseURL.appendingPathComponent("pokemon")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { completion(nil, nil)
                return
            }
            
            guard let array = dictionary["results"] as? Array<[String:Any]> else {
                completion(nil, nil)
                return
            }
            
            var pokeList = [Pokemon]()
            print(pokeList)
            
            for pokemon in array {
                pokeList.append(Pokemon(dictionary: pokemon))
            }
            completion(pokeList, nil)
        }.resume()
    }
    
    func fetchDetails(for pokemon: Pokemon, completion: @escaping (Result<Pokemon, NetworkError>) -> Void) {
        
        let pokemonURL = pokemon.url //baseURL.appendingPathComponent("pokemon/\(pokemon.name)")
        
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode == 401 {
                completion(.failure(.badRequest))
                return
            }
            
            if let error = error {
                print("Error receiving animal names: \(error)")
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                guard let pokemonDict = try JSONSerialization.jsonObject(with: data) as? [String: Any] else { return }
                
                guard let id = pokemonDict["id"] as? Int else { return }
                pokemon.identifier = id as NSNumber
                
                if let abilitiesArray = pokemonDict["abilities"] as? [[String: Any]] {
                    var abilities: [String] = []
                    for ability in abilitiesArray {
                        let abilityDict = ability["ability"] as? [String:String]
                        guard let abilityName = abilityDict?["name"] else { return }
                        abilities.append(abilityName)
                    }
                    pokemon.abilities = abilities
                }
                
                guard let spritesDict = pokemonDict["sprites"] as? [String:Any] else { return }
                pokemon.sprite = spritesDict["front_default"] as! String
                
                completion(.success(pokemon))
            } catch {
                NSLog("Error decoding animal names details: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
    
    func fetchImage(at url: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void ) {
        
        let imageURL = URL(string: url)!
        let request = URLRequest(url: imageURL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion( .failure(.badData))
                return
            }
            
            let image = UIImage(data: data)!
            completion(.success(image))
        }.resume()
    }
    
}
