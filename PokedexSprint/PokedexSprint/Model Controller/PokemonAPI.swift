//
//  PokemonAPI.swift
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    // TODO: this is yelling at me
    //@objc(sharedController) static let shared: PokemonAPI

    @objc func fetchAllPokemon(completion: @escaping ([JLAPokemon]?, Error?) -> Void) {
        print("fetchAllPokemon")
    }

    @objc func fillInDetails(for pokemon: JLAPokemon) {
        print("fillInDetails")
    }
}
