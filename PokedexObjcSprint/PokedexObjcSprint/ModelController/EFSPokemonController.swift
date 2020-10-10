//
//  EFSPokemonController.swift
//  PokedexObjcSprint
//
//  Created by Clayton Watkins on 10/9/20.
//

import UIKit

// MARK: - Network Error
enum NetworkError: String, Error {
    case badURL
    case badData
    case badJsonDecode
    case OtherError
    case DataTaskFailed
    case JSONdecodeFailed
}

class EFSPokemonController: NSObject {

    // MARK: - Properties
    private let fetchPokemonURL = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=1000")!
    private let fetchPokemonDetails = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    @objc(sharedController) static let shared = EFSPokemonController()
    var pokemon: [EFSPokemon] = []
    
    // MARK: - Network Calls
    @objc func fetchAllPokemon(completion: @escaping ([EFSPokemon]?, Error?) -> Void) {
        var request = URLRequest(url: fetchPokemonURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error with datatask: \(error)")
                completion(nil, NetworkError.DataTaskFailed)
                return
            }
            
            guard let data = data else {
                print("Error fetching data from datatask: \(NetworkError.badData)")
                completion(nil, error)
                return
            }
            
            var resultsDictionary : [String : Any?]
            
            do {
                resultsDictionary = try (JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] ?? [:])
            } catch {
                completion(nil, NetworkError.JSONdecodeFailed)
                print("Error decoding JSON from data: \(error)")
                return
            }
            
            guard let resultsArray = resultsDictionary["results"] as? [[String : String]] else { return }
            
            for pokemonResult in resultsArray {
                guard let pokemon = EFSPokemon(dictionary: pokemonResult) else { return }
                self.pokemon.append(pokemon)
                completion(self.pokemon, nil)
            }
        }.resume()
    }
    
    @objc func fillInDetail(for pokemon: EFSPokemon) {
        var request = URLRequest(url: fetchPokemonDetails.appendingPathComponent(pokemon.name.lowercased()))
        request.httpMethod = "GET"
        print(request)
        
        URLSession.shared.dataTask(with: request) {  (data, _, error) in
          
            guard let data = data else { return }
            var topLevelDictionary : [String:Any]?
            do {
                topLevelDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            } catch let err as NSError {
                print(err)
                return
            }
            // Getting ID
            guard let topLevelDict = topLevelDictionary else { return }
            guard let id = topLevelDict["id"] as? NSNumber else { return }
            pokemon.identifier  = id
            
            // Getting Sprite
            let spritesDictionary = topLevelDict["sprites"] as! [String:Any]
            let imageURLString = spritesDictionary["front_default"] as? String
            if let imageURL = URL(string: imageURLString!) {
                guard let data = try? Data(contentsOf: imageURL) else { return }
                pokemon.sprite = UIImage(data: data)!
            }
            
            // Getting Abilities
            let abilitiesArray = topLevelDict["abilities"] as! [[String:Any]]
            for item in abilitiesArray {
                let ability = item["ability"] as! [String:String]
                let abi = ability["name"]!
                pokemon.abilities.append(abi)
            }
           
        }.resume()
    }
    
}
