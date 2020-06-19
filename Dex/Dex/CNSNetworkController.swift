//
//  NetworkController.swift
//  Dex
//
//  Created by Ezra Black on 6/19/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import UIKit

let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

@objc (CNSPokemonController)
class CNSNetworkController: NSObject
{
    
    typealias CompletionHandler = ([CNSPokemon]?, Error?) -> Void
    
    @objc(sharedController) static let shared = CNSNetworkController()
    
    @objc func GET(pokemon: CNSPokemon)
    {
        let URLToUse = URLComponents(url: baseURL.appendingPathComponent(pokemon.name!),
                                     resolvingAgainstBaseURL: true)
        guard let requestURL = URLToUse?.url else { NSLog("requestURL is nil"); return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error
            {
                NSLog("Error fetching data: \(error)")
                return
            }
            guard let data = data else
            {
                NSLog("No data returned from data task");
                return
            }
            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                        options: []) as? [String : Any] else {
                                                                            let error = NSError(domain: "NetworkControllerErrorDomain",
                                                                                                code: 2,
                                                                                                userInfo: nil);
                                                                            
                                                                            throw error
                }
                let picture = dictionary["sprites"] as! [String : Any]
                let imageString = picture["front_default"] as! String
                pokemon.sprites = imageString
                let id = dictionary["id"] as! Int
                pokemon.id = Int32(id)
                let Dictionaries = dictionary["abilities"] as! [[String : Any]]
                var names: [String] = []
                for abilityDictionary in Dictionaries {
                    let ability = abilityDictionary["ability"] as! [String : Any]
                    let name = ability["name"] as! String
                    names.append(name)
                }
                
                pokemon.abilities = names
                
            } catch
            {
                _ = NSError(domain: "NetworkControllerErrorDomain",
                            code: 4,
                            userInfo: nil);
                return;
            }
        }.resume()
    }
    
    @objc func GET(completion: @escaping CompletionHandler = { _,_  in })
    {
        let urlComponents = URLComponents(url: baseURL,
                                          resolvingAgainstBaseURL: true)
        guard let requestURL = urlComponents?.url else
        { NSLog("URL is nil"); completion(nil,
                                          NSError(domain: "NetworkControllerErrorDomain",
                                                  code: 0,
                                                  userInfo: nil));
            return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request)
        { (data, _, error) in
            if let error = error
            {
                NSLog("Error fetching data: \(error)")
                DispatchQueue.main.async
                    {
                        completion(nil, error)
                }
                return
            }
            
            guard let data = data else
            {
                NSLog("No data");
                DispatchQueue.main.async
                    {
                        completion(nil, NSError(domain: "NetworkControllerErrorDomain", code: 1, userInfo: nil))
                }
                return
            }
            do
            {
                guard let dictionary = try JSONSerialization.jsonObject(with: data,
                                                                        options: []) as? [String : Any] else
                {
                    let error = NSError(domain: "NetworkControllerErrorDomain",
                                        code: 2,
                                        userInfo: nil);
                    throw error
                }
                guard let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else
                {
                    let error = NSError(domain: "NetworkControllerErrorDomain",
                                        code: 3,
                                        userInfo: nil);
                    throw error
                }
                let pokemon = pokemonDictionaries.compactMap { CNSPokemon(dictionary: $0) }
                
                DispatchQueue.main.async
                    {
                        completion(pokemon, nil)
                }
            } catch
            {
                DispatchQueue.main.async
                    {
                        completion(nil, error)
                }
            }
        }.resume()
    }
}

