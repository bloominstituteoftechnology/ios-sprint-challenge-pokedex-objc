//
//  PokemonController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 2/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
}

@objc class PokemonController: NSObject {
    
    //MARK: - Properties
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc var pokemonArray: [Pokemon] = []
    
    private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    //MARK: - Methods
    
    @objc func fetchPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
//        var request = URLRequest(url: baseUrl)
//        request.httpMethod = HTTPMethod.get.rawValue
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//
//            if let _ = error {
//                completion(nil, error)
//                return
//            }
//
//            guard let data = data else {
//                completion(nil, error)
//                return
//            }
//
//            let decoder = JSONDecoder()
//
//            do {
//                let pokemon = try decoder.decode([Pokemon], from: data)
//                self.pokemonArray = pokemon
//            } catch {
//                print("Error decoding pokemon names: \(error)")
//                completion(nil, error)
//                return
//            }
//        }.resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) -> PokemonDetail? {
//        let pokemonURL = URL(string: "\(pokemon.url)")!
//
//        var request = URLRequest(url: pokemonURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//
//        URLSession.shared.dataTask(with: request) { (data, _, error) in
//
//            if let error = error {
//                print("Error loading data: \(error)")
//                return
//            }
//
//            guard let data = data else { return }
//
//            let decoder = JSONDecoder()
//
//            do {
//                let pokemon = try decoder.decode(PokemonDetail, from: data)
//                return pokemon
//            } catch {
//                print("Error decoding pokemon details: \(error)")
//                return
//            }
//        }
        return PokemonDetail(name: pokemon.name, id: pokemon.name, sprite: pokemon.name, abilities: [pokemon.name])
    }
}

//Watch Quakes to see the networking in swift
//Fix networking calls
