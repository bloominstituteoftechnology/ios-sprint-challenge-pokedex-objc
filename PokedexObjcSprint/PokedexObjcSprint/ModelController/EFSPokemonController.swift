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
        }
    }
}
