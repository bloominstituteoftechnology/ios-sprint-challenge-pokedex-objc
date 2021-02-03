//
//  PokemonController.swift
//  PokedexSprint
//
//  Created by Norlan Tibanear on 1/31/21.
//

import UIKit

enum NetworkError: Error {
    case noData
    case otherError
    case failedJSONDecoder
    case badUrl
}

@objc class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private let pokemonDetailsURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc(shareController) static let shared = PokemonController()
    
    var pokemon: [Pokemon] = []
    
    @objc func fetchPokemons(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error \(error)")
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            var dict : [String : Any]
            do {
                dict = try (JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] ?? [:])
            } catch {
                print("Error decoding json")
                completion(nil, NetworkError.failedJSONDecoder)
                return
            }
            
            guard let results = dict["results"] as? [[String : String]] else { return }
            for result in results {
                guard let pokemon = Pokemon(dictionary: result) else { return }
                self.pokemon.append(pokemon)
                completion(self.pokemon, nil)
            }
            
        }.resume()
        
    }//
    
    
    @objc func pokemonDetail(for pokemon: Pokemon) {
        var request = URLRequest(url: pokemonDetailsURL.appendingPathComponent(pokemon.name))
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error  = error {
                print("Error \(error)")
                return
            }
        
            guard let data = data else {
                print("No dataavailable")
                return
            }
            
            var dict : [String:Any]?
            do {
                dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                guard let pokeDict = dict else { return }
                guard let id = pokeDict["id"] as? NSNumber else { return }
                pokemon.identifier = id
                
                let pokeSprites = dict!["sprites"] as! [String:Any]
                let pokeImage = pokeSprites["front_default"] as? String
                if let imageString = URL(string: pokeImage!) {
                    
                    let data = try? Data(contentsOf: imageString)
                    pokemon.sprite = UIImage(data: data!)
                }
                
                let pokeAbilities = dict!["abilities"] as! [[String:Any]]
                for poke in pokeAbilities {
                    let abilities = poke["ability"] as! [String:String]
                    let name = abilities["name"]!
                    pokemon.abilities.append(name)
                }
                
                
            } catch {
                print("Error getting Pokemon details \(error)")
            }
            
            
        }.resume()
        
    }//
    
    
}// CLASS
