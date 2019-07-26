//
//  PokemonAPIController.swift
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation


@objc class PokemonAPIController: NSObject {
    
    //@objc(sharedController) static let shared: PokemonAPIController
    
    @objc func fetchAllPokemon(completion: @escaping ([JGPPokemon]?, Error?) -> Void) {
        
    }
    
    @objc func fillInDetails(for pokemon: JGPPokemon) {
        
    }
}
