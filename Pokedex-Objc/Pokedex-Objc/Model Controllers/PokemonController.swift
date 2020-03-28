//
//  PokemonController.swift
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class PokemonController: NSObject {
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    @objc(sharedController) static let shared = PokemonController()
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    let userDefaults = UserDefaults.standard
    let key = "PokemonController.pokemon_list"
    let cache = JACCache()
    
    @objc
    func getPokemon(with searchTerm: String, completion: @escaping (JACPokemon?, Error?) -> Void) {
        let searchURL = baseURL
            .appendingPathComponent("pokemon")
            .appendingPathComponent(searchTerm)
        
        var request = URLRequest(url: searchURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error searching for pokemon on line \(#line) in \(#file): \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from searching for pokemon")
                completion(nil, nil)
                return
            }
//            print(String(data: data, encoding: .utf8))
            
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                    completion(nil, NSError())
                    return
                }
                
                let newPokemon = JACPokemon(dictionary: dictionary)
                newPokemon.fillInDetails(with: dictionary)
                self.fetchPokemonImage(for: newPokemon)
                newPokemon.name = newPokemon.name.capitalized
                
                completion(newPokemon, nil)
            } catch {
                NSLog("Error decoding pokemon on line \(#line): \(error)")
                completion(nil, error)
            }
        }.resume()
    }
    
    @objc
    func fetchPokemonImage(for pokemon: JACPokemon) {
        guard let imageURL = pokemon.imageURL else { return }
        
        if let image = cache.getValueWithKey(key) {
            pokemon.image = image
            pokemon.notify()
            return
        }
        
        let request = URLRequest(url: URL(string: imageURL)!)
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let _ = error { return }
            guard let data = data else { return }
            let image = UIImage(data: data)
            
            if let image = image {
                pokemon.image = image
                self.cache.setValue(image, withKey: imageURL)
                pokemon.notify()
            }
        }.resume()
    }
    
    override init() {
        super.init()
    }
    
    @objc
    func save(pokemon: [JACPokemon]) {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: pokemon, requiringSecureCoding: false)
            userDefaults.set(data, forKey: key)
        } catch {
            NSLog("Unable to save array to userdefaults. Data will NOT be saved: \(error)")
        }
    }
    
    @objc
    func loadPokemon() -> [JACPokemon] {
        let arrayData = userDefaults.data(forKey: key)
        if let data = arrayData {
            do {
                let pokeList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
                if let pokemon = pokeList as? [JACPokemon] {
                    return pokemon
                }
            } catch {
                NSLog("Unable to fetch array from userdefaults: \(error)")
            }
        }
        return []
    }
}
