//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

@objc
class PokemonAPI: NSObject {
    
    @objc var pokemon: Pokemon?
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc private var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    @objc var pokemonResults: [Pokemon] = []
    
    override init() {
        super.init()
   
       self.fetchAllPokemon { (pokemonResults, error) in
        
    if let error = error {
       print("Error initializing with pokemon array: \(error)")
         return
    }
        self.pokemonResults = pokemonResults!
    }
  }
        
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
     var request = URLRequest(url: baseURL)
     request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data , response, error) in
        
     if let error = error {
        print("Error: \(error)")
        completion(nil,error)
        return
    }
        
     if let response = response as? HTTPURLResponse,
      response.statusCode != 200 {
        NSLog("Response Code: \(response.statusCode)")
        completion(nil,error)
        return
    }
        
    guard let data = data else {
        completion(nil,error)
        return
    }
        print("\nData returned when fetching all pokemon: \(data)")
        
        do {
        
    guard let jsonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
        NSLog("Bad Decode fetching all pokemon")
          return
    }
        print("Decoded jsonDictionary: \(jsonDictionary)")
        
    if let resultsDictionary = jsonDictionary["results"] as? [[String: String]] {
        
     for pokemon in resultsDictionary {
     let newPokemon = Pokemon(dictionary: pokemon)
     self.pokemonResults.append(newPokemon)
    }
}
    completion(self.pokemonResults,nil)
      return
  } catch {
     print("Error: \(error)")
    completion(nil,error)
       return
    }
  }.resume()
}

 @objc func fillInDetails(for pokemon: Pokemon) {
        
    let requestURL = baseURL.appendingPathComponent(pokemon.name.lowercased())
                
    var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
    URLSession.shared.dataTask(with: request) { (data, response, error) in
            
    if let error = error {
        NSLog("Error fetching pokemon details: \(error)")
        return
   }
            
     if let response = response as? HTTPURLResponse,
        response.statusCode != 200 {
        NSLog("\(response.statusCode)")
        return
   }
      guard let data = data else {
        NSLog("No data returned when fetching pokemon details")
        return
 }
      do {
                
     if let pokemonDictionary = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    
     if let abilitiesArray = pokemonDictionary["abilities"] as? [[String:Any]] {
      let pokemonAbilities: NSMutableArray = []
                        
       for ability in abilitiesArray {
                            
       let abilityDictionary = ability["ability"] as? [String: String]
                            
       guard let abilityName = abilityDictionary?["name"] else { return }
                            
        pokemonAbilities.add(abilityName)
        pokemon.abilities = pokemonAbilities
    }
}
    
        if let spriteDictionary = pokemonDictionary["sprites"] as? [String: Any] {
                        
        let imageString = spriteDictionary["front_default"] as? String
                        
        guard let imageURL = URL(string: imageString ?? "") else { return }
                        
        self.loadImage(url: imageURL) { (result) in
                            
        do {
        let data = try result.get()
        if let imageData = data {
          pokemon.imageURL = imageData
    }
        } catch {
        NSLog("Couldn't load image")
        }
    }
}
                    
      if let id = pokemonDictionary["id"] as? Int32 {
        pokemon.identifier = id
    }
}
      self.pokemon = pokemon
        print("\nPokemon returned name: \(pokemon.name)")
            return
                
    } catch {
        NSLog("Error decoding pokemon object: \(error)")
            return
      }
    }.resume()
}
    
private func loadImage(url: URL, completion: @escaping (Result<Data?, NetworkingError>) -> Void) {
   URLSession.shared.dataTask(with: url) { (data, response, error) in
    if let error = error {
        print("Error: \(error)")
        completion(.failure(.serverError(error)))
        return
    }
            
    if let response = response as? HTTPURLResponse,
        response.statusCode != 200 {
        NSLog("\(response.statusCode)")
     completion(.failure(.unexpectedStatusCode(response.statusCode)))
        return
    }
    guard let data = data else {
     completion(.failure(.noData))
        return
    }
     completion(.success(data))
    }.resume()
    }
}
