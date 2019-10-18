//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()

	@objc func fetchAllPokemon(completion: @escaping ([Pokeman]?, Error?) -> Void) {

	}

	@objc func fillInDetails(for pokemon: Pokeman) {

	}
}
