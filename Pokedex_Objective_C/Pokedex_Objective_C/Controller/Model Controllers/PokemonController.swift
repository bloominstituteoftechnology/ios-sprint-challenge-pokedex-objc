//
//  PokemonController.swift
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

@objc class PokemonController: NSObject {
    // MARK: - Singleton -
    @objc static let shared = PokemonController()

    @objc private override init() {
        super.init()
    }
    // MARK: - Properties -
    @objc var pokemon: [HSIPokemon]?
    
}
