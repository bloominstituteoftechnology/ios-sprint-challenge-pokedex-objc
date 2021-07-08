//
//  PokemonAPI.swift
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import Foundation

@objc class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc (fetchAllPokemonWithCompletionBlock:)
    func fetchAllPokemon(completion: @escaping ([BHPokemon]?, Error?) -> Void){
        
        let urlString = "\(baseURL.absoluteString)pokemon/?limit=1000"
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
                    
                    let tempPokemon: BHPokemon = BHPokemon(json: pokemonTempResultsDict)
                    self.results.append(tempPokemon)
                }
                
                completion(nil, nil)
                
            } catch {
                completion(nil, error)
                return
            }
            
            }.resume()
        
    }
    
    @objc func fillInDetails(for pokemon:BHPokemon){
        
        let urlString = "\(pokemon.moreInfoURLString)"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url){ (data, _, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            guard let data = data else {
                return
            }
            
            
            do {
                
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    throw NSError()
                    
                }
                
                let updatedPokemon = pokemon.update(withJSON: dictionary)
                
                guard let id = updatedPokemon.identifier else { fatalError("no identifier associated with pokemon") }
                let index = Int(id)! - 1

                self.results[index] = updatedPokemon


            } catch {
                
                return
            }
            
            }.resume()
        
    }
    
    
    // MARK: - Properties
    @objc dynamic var results: [BHPokemon] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
}

