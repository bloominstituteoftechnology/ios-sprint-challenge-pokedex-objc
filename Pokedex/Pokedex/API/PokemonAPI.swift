//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

@objc(HSVPokemonAPI)
class PokemonAPI: NSObject {
	
	@objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
	
	
	@objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
		
	}
	
	@objc func fillInDetails(for pokemon: Pokemon) {
		
	}
}
