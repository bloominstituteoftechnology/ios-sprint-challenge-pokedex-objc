//
//  PokemonController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 2/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

enum NetworkError: Error {
    case badData
    case otherError
    case noDecode
}

@objc(PokemonController)
class PokemonController: NSObject {
    
    //MARK: - Properties
    
    @objc(sharedController)
    static let shared = PokemonController()
    
    var pokemonArray: [Pokemon] = []
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //MARK: - Methods
    
    func fetchPokemon(completion: @escaping (Result<[Pokemon], NetworkError>) -> Void) {
        
        var request = URLRequest(url: baseUrl)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let names = try decoder.decode([Pokemon], from: data)
                completion(.success(names))
                self.pokemonArray = names
            } catch {
                print("Error decoding pokemon names: \(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
}
