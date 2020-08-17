//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

import Foundation


class PokemonController: NSObject {

    @objc(sharedController) static let shared = PokemonController()

    @objc func fetchAllPokemon(completion: @escaping ([SMAPokemon]?, Error?) -> Void) {
        
    }

    @objc func fillInDetails(for pokemon: SMAPokemon) {
        
    }
}
