//
//  PokemonAPI.swift
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()
   
    let baseURL = URL(string: "https://pokeapi.co/api/v2")!
    
    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void) {
        
    }
    
    @objc func fillInDetails(for pokemon: LSIPokemon) {
        
    }
    
}
