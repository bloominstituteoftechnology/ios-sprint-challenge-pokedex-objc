//
//  PokemonGET.swift
//  Pokedex-ObjC
//
//  Created by Iyin Raphael on 3/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

import Foundation

private let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!

class PokemonGET: NSObject {
    

    
    @objc func fetchPokemon(completion: @escaping ([LSIPokemon]?, Error?)-> Void){
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching Pokemons: \(error)")
                completion(nil, error)
            }
            guard let data = data else {
                NSLog("Data not found")
                return
            }
            var pokeArray = [LSIPokemon]()
            do{
                let dictionary = try JSONSerialization.jsonObject(with: data, options:[] ) as! [String: Any]
                
                guard let pokemonArray = dictionary["results"] as? [[String: String]] else {return}
                
                for poke in pokemonArray {
                    pokeArray.append(LSIPokemon(dictionary: poke))
                }
            } catch {
                completion(nil, error)
            }
            completion(pokeArray,nil)
            }.resume()
    }
    
    
    @objc func fetchDetails(for pokemon: LSIPokemon) {
        let url = URL(string: pokemon.url)!
       guard pokemon.sprites == nil else {return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error geting data: \(error)")
                return
            }
            guard let data = data else {
                NSLog("Data not found")
                return
            }
            
            do{
                let dictionary = try JSONSerialization.jsonObject(with: data, options:[] ) as! [String: Any]
                
                if let idInt = dictionary["id"] as? Int{
                    pokemon.id = String( idInt)
                }
                
                if let abilitiesArray = dictionary["abilities"] as? [[String: Any]] {
                    pokemon.abilitiesArray(abilitiesArray)
                }
                if let spritesDict = dictionary["sprites"] as? [String:String?] {
                    let spriteURL = spritesDict["front_default"]
                    pokemon.sprites = spriteURL!
                }
            } catch {
                NSLog("Error geting sprites: \(error)" )
                return
            }
            }.resume()
    }
}
