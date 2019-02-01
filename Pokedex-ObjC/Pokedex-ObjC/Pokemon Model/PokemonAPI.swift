//
//  PokemonAPI.swift
//  Pokedex-ObjC
//
//  Created by Jerrick Warren on 2/1/19.
//  Copyright © 2019 Jerrick Warren. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void)
    
    @objc func fillInDetails(for pokemon: LSIPokemon)
}
