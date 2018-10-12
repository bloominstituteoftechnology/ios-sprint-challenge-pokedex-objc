//
//  PokemonController.swift
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

@objc(SMFPokemonController)
class PokemonController : NSObject {
    
    @objc var pokemons: [SMFPokemon] = []
    
    @objc func fetchAllPokemon() {
        pokemons = [] // Result of fetch request
    }
    
    @objc func fillInDetails(for pokemon: SMFPokemon) {
        
    }
}
