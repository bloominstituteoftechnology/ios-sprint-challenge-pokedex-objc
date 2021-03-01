//
//  PokemonController.swift
//  ObjCPokedex
//
//  Created by Craig Belinfante on 2/24/21.
//

import UIKit

class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    let pokemonDetail = Pokemon()
    
    @objc(sharedController) static let shared = PokemonController()
    @objc func fetchPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let limit = URLQueryItem(name: "limit", value: "500")
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        print(urlComponents)
        
        urlComponents?.queryItems = [limit]
        guard let url = urlComponents?.url else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    completion(nil, error)
                    return
                }
                
                let dictionaryResults = PokemonResults(dictionary: dictionary)
                let pokemonArray = dictionaryResults.pokemonResults
                
                completion(pokemonArray, nil)
                
            } catch {
                completion(nil, error)
                print("Error fetching pokemon: \(error)")
            }
            
        }.resume()
    }
    
    @objc func pokemonResult(with pokemon: Pokemon) {
        
        var requestURL = URLRequest(url: baseURL.appendingPathComponent(pokemon.name))
        requestURL.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching results: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Error no data")
                return
            }
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    NSLog("Error decoding dictionary")
                    return
                }
                
                let results = Pokemon(dictionary: dictionary)
                
                pokemon.update(withID: results.identifier, name: results.name, abilities: results.abilities, sprites: results.sprites)
                print(results)
                
                
            } catch {
                NSLog("Error: \(error)")
            }
            
        }.resume()
    }
    
    
    @objc func fetchImage(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        var request = URLRequest(url: baseURL.appendingPathComponent(pokemonDetail.sprites))
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image, nil)
            }
        }
        task.resume()
    }
}
