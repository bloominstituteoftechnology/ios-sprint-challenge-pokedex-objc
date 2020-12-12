//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
}
