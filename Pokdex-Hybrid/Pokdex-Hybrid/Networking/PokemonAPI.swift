//
//  PokemonAPI.swift
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
}
