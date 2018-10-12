//
//  NetworkController.swift
//  Pokemon-ObjC
//
//  Created by Jonathan T. Miles on 10/12/18.
//  Copyright © 2018 Jonathan T. Miles. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {
    
    @objc(sharedController) static let shared: PokemonAPI
    
    @objc func fetchAllPokemon(completion: @escaping ([JTMPokemon]?, Error?) -> Void) {
        
    }
    
    @objc func fillInDetails(for pokemon: JTMPokemon) {
        
    }
}
