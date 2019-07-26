//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Alex on 7/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import Foundation
import UIKit
@objc(LSIPokemonAPI)

class PokemonAPI: NSObject {
    
    // MARK: - Properties
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    private var allPokemon: [LSIPokemon]
    
    // MARK: - VC Lifecycle
    
    override init() {
        self.allPokemon = []
    }
    
    // MARK: - Obj-c
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    //    @objc(sharedController) static let shared: PokemonAPI
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        let request = URLRequest(url: baseUrl)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("HERE Error: \(error.localizedDescription)")
                return completion(nil, error)
            }
            
            guard let data = data else {
                NSLog("HERE Error pulling Pokemon: \(error?.localizedDescription)")
                return completion(nil, NSError())
            }
            
            do {
                guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let pokeDict = dict["results"] as? [[String: Any]] else {
                        return completion(nil, error)
                }
                
                self.allPokemon = pokeDict.map { LSIPokemon(dictionary: $0)}
                completion(self.allPokemon, nil)
            } catch {
                return completion(nil, error)
            }}.resume()
    }
    
    @objc func fillInDetails(for pokemon: LSIPokemon) {
        let url = URL(string: pokemon.pokemonUrl.absoluteString)!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                return NSLog("HERE Error: \(error.localizedDescription)")
            }
            
            guard let data = data else {
                return NSLog("HERE Error: \(error?.localizedDescription)")
            }
            
            do {
                guard let pokeDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                var allAbilities: [String] = []
                
                guard let identifier = pokeDict["id"] as? Int else {return}
                pokemon.identifier = String(identifier)
                
                if let abilities = pokeDict["abilities"] as? [[String: Any]] {
                    for ability in abilities {
                        let myAbility = ability["ability"] as! [String: Any]
                        let name = myAbility["name"] as! String
                        allAbilities.append(name)
                    }
                    pokemon.abilities = allAbilities
                }
                
                if let sprites = pokeDict["sprites"] as? [String: Any] {
                    let spriteUrl: String = sprites["front_default"] as! String
                    let url = URL(string: spriteUrl)!
                    self.pullImage(url: url, completion: { (image, _) in
                        pokemon.image = image!
                    })
                }
            } catch (let error) {
                return print("HERE Error: ", error)
            }}.resume()
    }
    
    // MARK: - General Functions

    private func pullImage(url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {return completion(nil, error)}
            
            guard let data = data else {return completion(nil, error)}
            
            let image = UIImage(data: data)
            completion(image, error)
            }.resume()
    }
    
    
}
