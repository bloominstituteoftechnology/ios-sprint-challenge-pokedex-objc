//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Carolyn Lea on 10/12/18.
//  Copyright © 2018 Carolyn Lea. All rights reserved.
//

import Foundation

private let baseURL = URL(string:"http://pokeapi.co/api/v2/pokemon")!

class PokemonController: NSObject
{
    @objc(sharedController) static let shared: PokemonController = PokemonController()
    
    var pokemons: [Pokemon] = []
    
    
@objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void)
{
    let url = baseURL.appendingPathExtension("json")
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        
        if let error = error
        {
            NSLog("Error retrieving pokemons from server: \(error)")
            DispatchQueue.main.async {
                
                completion(nil, error)
            }
            return
        }
        
        guard let data = data else {
            
            DispatchQueue.main.async {
                
                completion(nil, NSError())
            }
            return
        }
        
        do {
            guard let results = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else {
                
                DispatchQueue.main.async {
                    
                    completion(nil, NSError())
                }
                return
            }
            
            guard let pokemonDictionaries = results["results"] as? NSArray else {
                
                DispatchQueue.main.async {
                    
                    completion(nil, NSError())
                }
                return;
            }
            
            var pokemons = [Pokemon]()
            
            for pokemonDictionary in pokemonDictionaries {
                
                guard let pokemonDictionary = pokemonDictionary as? [AnyHashable : Any] else { continue }
                
                let pokemon = Pokemon(dictionary: pokemonDictionary)
                pokemons.append(pokemon)
            }
            
            DispatchQueue.main.async {
                
                self.pokemons = pokemons
                completion(pokemons, nil)
            }
        }
        catch
        {
            NSLog("Unable to encode name: \(error)")
            DispatchQueue.main.async {
                
                completion(nil, error)
            }
            return
        }
        
        }.resume()
}

@objc func fillInDetails(for pokemon: Pokemon)
{
    let url = baseURL.appendingPathComponent(pokemon.name).appendingPathExtension("json")
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error
        {
            NSLog("Error retrieving pokemon info from server: \(error)")
            return
        }
        
        guard let data = data else { return }
        
        do
        {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any] else { return }
            
            DispatchQueue.main.async {
                
                pokemon.fill(with: dictionary)
            }
        }
        catch
        {
            NSLog("Unable to encode name: \(error)")
        }
        return
    }.resume()
}


}
