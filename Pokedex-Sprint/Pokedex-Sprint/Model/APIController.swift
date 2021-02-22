//
//  APIController.swift
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 12/14/20.
//

import UIKit

enum NetworkError: Error {
    case noData
    case otherError
    case failedJSONDecoder
    case badURL
}

@objc class APIController: NSObject {
    
    @objc(sharedController) static let shared = APIController()
 
    var pokemon: [Pokemon] = [] // This is where I am able to bring the SAEPokemon into the API controller with using a custom name.
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    private let detialURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    @objc func fetchPokemons(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("No data was able to be retrieved \(error)")
                completion(nil, NetworkError.noData)
                return
            }
            
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            var dictionary : [String: Any]
            do {
                dictionary = try (JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] ?? [:])
            } catch {
                NSLog("Was not able to decode JSON: \(error)")
                completion(nil, NetworkError.failedJSONDecoder)
                return
            }
            
            guard let results = dictionary["results"] as? [[String : String]] else { return }
            for result in results {
                guard let pokemon = Pokemon(dictionary: result) else { return }
                self.pokemon.append(pokemon)
                completion(self.pokemon, nil)
            }
        }.resume()
    }
    
    @objc func pokemonDetail(for pokemon: Pokemon) {
        var urlRequest = URLRequest(url: detialURL.appendingPathComponent(pokemon.name))
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                NSLog("An error has ocurred: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("Data was not able to be pulled \(NetworkError.noData)")
                return
            }
            
            var dictionary : [String:Any]?
            do {
                dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                guard let pokemonDictionary = dictionary else { return }
                guard let id = pokemonDictionary["id"] as? NSNumber else { return }
                pokemon.identifier = id
                
                let pokemonSprites = dictionary!["sprites"] as! [String:Any]
                let pokemonImage = pokemonSprites["front_default"] as? String
                if let imageString = URL(string: pokemonImage!) {
                    
                    let data = try? Data(contentsOf: imageString)
                    pokemon.sprite = UIImage(data: data!)
                }
                
                let pokemonAbilities = dictionary!["abilities"] as! [[String:Any]]
                for pokemonAb in pokemonAbilities {
                    let abilities = pokemonAb["ability"] as! [String:String]
                    let name = abilities["name"]!
                    pokemon.abilities.append(name)
                }
            } catch {
                print("Error getting Pokemon details \(error)")
            }
        } .resume()
    }
    
}
