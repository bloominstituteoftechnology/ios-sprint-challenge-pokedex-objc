//
//  PokemonClient.swift
//  Sprint12
//
//  Created by David Doswell on 10/12/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import UIKit

@objcMembers
class PokemonAPI: NSObject {
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
//    @objc(sharedController) static let shared: PokemonAPI
    
    @objc func fetchAllPokemon(completion: @escaping ([DODPokemon]?, Error?) -> Void) {
        
        let request = URLRequest(url: baseURL)
        
    }
    
    var name: String?
    var identifier: String?
    var sprite: String?
    var abilities: String?
    
    @objc func fillInDetails(for pokemon: DODPokemon) {
        
        self.name = pokemon.name
        self.identifier = pokemon.identifier
        self.sprite = pokemon.sprite
        self.abilities = pokemon.abilities
        
    }
    
}
