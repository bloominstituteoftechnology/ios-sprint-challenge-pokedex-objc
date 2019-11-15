//
//  PokemonController.swift
//  Pokedex-Objc
//
//  Created by Jordan Christensen on 11/16/19.
//  Copyright © 2019 Mazjap Co. All rights reserved.
//

import UIKit

class PokemonController: NSObject {

    @objc(sharedController) static let shared = PokemonController()

    @objc func fetchAllPokemon(completion: @escaping ([JACPokemon]?, Error?) -> Void) {
        
    }

    @objc func fillInDetails(for pokemon: JACPokemon) {
        
    }
}
