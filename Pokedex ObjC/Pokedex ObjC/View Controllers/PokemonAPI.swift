//
//  PokemonAPI.swift
//  Pokedex ObjC
//
//  Created by Wyatt Harrell on 5/22/20.
//  Copyright © 2020 Wyatt Harrell. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([WAHPokemon]?, Error?) -> Void) {
        
    }

    @objc func fillInDetails(for pokemon: WAHPokemon) {
        
    }
}
