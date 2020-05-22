//
//  NetworkController.swift
//  Pokedex-Obj-C
//
//  Created by Christopher Devito on 5/22/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import Foundation

class NetworkController: NSObject {
    // MARK: - Properties
    @objc(sharedController) static let shared: NetworkController = NetworkController()
    @objc var pokemons: [Pokemon] = []
    @objc var pokemonList: [PokemonShort] = []
    let baseURL = "https://pokeapi.co/api/v2/pokemon/"

    // MARK: - Network Methods
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        let urlRequest = URLRequest(url: URL(string: baseURL)!)
        let resourceNumber = URLQueryItem(name: "limit", value: "60")
        

    }

    @objc func fillInDetails(for pokemon: Pokemon) {

    }

    // MARK: - Helper Methods
}
