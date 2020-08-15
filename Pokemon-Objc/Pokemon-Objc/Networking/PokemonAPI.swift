//
//  PokemonAPI.swift
//  Pokemon-Objc
//
//  Created by Chad Parker on 8/14/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()

    private override init() {}

    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {

    }

    @objc func fillInDetails(for pokemon: LSIPokemon) {
        
    }
}
