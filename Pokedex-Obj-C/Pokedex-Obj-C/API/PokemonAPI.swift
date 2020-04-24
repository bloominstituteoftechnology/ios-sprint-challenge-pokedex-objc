//
//  PokemonAPI.swift
//  Pokedex-Obj-C
//
//  Created by scott harris on 4/24/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([SAHPokemon]?, Error?) -> Void) {
        
        
    }
    
//    @objc func fillInDetails(for pokemon: LSIPokemon)
}
