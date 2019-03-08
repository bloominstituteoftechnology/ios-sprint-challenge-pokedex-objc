//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import Foundation

class PokemonController: NSObject {
    
    @objc(shared) static let shared = PokemonController()
    
    @objc (getAvailablePokemonWithCompletionBlock:)
    func getAvailablePokemon(completion: @escaping ([BHPokemonTemporaryResults]?, Error?) -> Void){
        
        let urlString = "\(baseURL.absoluteString)pokemon/"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url){ (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                return completion(nil, NSError())
            }
            
            
            do {
                
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                        throw NSError()
                    
                }
                guard let pokemonDictionaries = dictionary["results"] as? [[String:String]] else { return }

                for pokemonTempResultsDict in pokemonDictionaries {
                    
                    let tempPokemon: BHPokemonTemporaryResults = BHPokemonTemporaryResults(json: pokemonTempResultsDict)
                    self.results.append(tempPokemon)
                }
                
                completion(nil, nil)
                
            } catch {
                completion(nil, error)
                return
            }
            
            }.resume()
        
    }
    
    @objc (getPokemonWithName:CompletionBlock:)
    func getPokemon(name:String, completion: @escaping (BHPokemon?, Error?) -> Void){
        
        let urlString = "\(baseURL.absoluteString)pokemon/\(name)"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url){ (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                return completion(nil, NSError())
            }
            
            
            do {
                
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw NSError()
                    
                }
                let pokemon = BHPokemon(json: dictionary)
                
                completion(pokemon, nil)
                
            } catch {
                completion(nil, error)
                return
            }
            
            }.resume()
        
    }
    
    
    // MARK: - Properties
    @objc var results: [BHPokemonTemporaryResults] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
}

