//
//  PokedexController.swift
//  Pokedex
//
//  Created by Yvette Zhukovsky on 2/1/19.
//  Copyright © 2019 Yvette Zhukovsky. All rights reserved.
//
import UIKit
import Foundation
@objc(YZIPokedexController)
class PokedexController : NSObject {
@objc(sharedController) static let shared = PokedexController()


private static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchPokemons(completion: @escaping ([YZIPokedex]?, Error?) -> Void) {
    
    URLSession.shared.dataTask(with: PokedexController.baseURL) { (data, _, error) in
    if let error = error {
    NSLog("Error fetching pokemons: \(error)")
    completion(nil, error)
    return
    }
    
    guard let data = data else {
    completion(nil, NSError())
    return
}
    do {
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
    let results = dictionary["results"] as? [[String: String]] else {
    
    NSLog("JSON not a dictionary")
    completion(nil, NSError())
    return
    }
    

    var pokies: [YZIPokedex] = []
    for pokeDict in results {
    let pokemon = YZIPokedex(dictionary: pokeDict)
pokies.append(pokemon)
    }
    completion(pokies, nil)
    } catch {
    NSLog("Error decoding \(error)")
    completion(nil, error)
    return
    }
    }.resume()
}

@objc func fillInDetails(for pokemon:YZIPokedex) {
    
    let url = PokedexController.baseURL.appendingPathComponent(pokemon.name).appendingPathComponent("/")
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
            NSLog("Error fetching pokemon\(error)")
            return
        }
        
        guard let data = data else { return }
        
        do {
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
            pokemon.update(with: dictionary)
        } catch {
            NSLog("Error decoding data: \(error)")
            return
        }
        
        guard let imageURL = pokemon.imagesURL else { return }
        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, _, error) in
            if let error = error {
                NSLog("Error fetching pokemon image: \(error)")
                return
            }
            
            guard let data = data,
                let image = UIImage(data: data) else { return }
            
            pokemon.image = image
        }).resume()
        }.resume()

}
    



}
