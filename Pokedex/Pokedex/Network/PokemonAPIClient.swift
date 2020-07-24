//
//  PokemonAPIClient.swift
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//
import UIKit
private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

typealias CompletionHandler = (Result<[Pokemon], NetworkError>) -> Void
typealias SpriteResultCompletionHandler = (Result<UIImage, NetworkError>) -> Void

@objc class PokemonAPIClient: NSObject {
    
    @objc func fetchSortedPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        //TODO:
        self.fetchAllPokemon { (result) in
            
            switch result {
                
            case .failure(let error):
                completion(nil, NSError(domain: error.localizedDescription, code: 0))
            case .success(let pokemon):
                completion(pokemon.sorted(by: { $0.name < $1.name }), nil)
            }
        }
    }
    
    func fetchAllPokemon(completion: @escaping CompletionHandler) {
        
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        
        components.queryItems = [
            
            URLQueryItem(name: "limit", value: "1000")]
        
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            
            completion(PokemonResultDecoder().decode(result))
            
        }
            
        .resume()
        
    }
    
    @objc func fetchDetails(for pokemon: Pokemon) {
        
        let request = URLRequest(url: baseURL.appendingPathComponent(pokemon.name))
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            
            switch result {
                
            case .failure(let error):
                
                print(error)
                
            case .success(let data):
                
                do {
                    
                    guard let dict = try JSONSerialization
                        .jsonObject(with: data, options: .fragmentsAllowed) as? Dictionary<String, Any> else {
                            throw NetworkError.decodingError(NSError(domain: "⚠️ Error decoding pokemon details", code: 0))
                    }
                    
                    self.fetchPokeDetails(for: pokemon, with: dict)
                    
                } catch {
                    
                    print(error)
                }
            }
        }
        .resume()
    }
    
    func fetchPokeImage(url: URL, completion: @escaping SpriteResultCompletionHandler) {
        
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { (result) in
            
            completion(ImageResultDecoder().decode(result))
        }
            
        .resume()
    }
    
    // MARK: Private funcs
    
    privat
    
    
    
    
}
