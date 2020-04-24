//
//  PokemonAPI.swift
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class PokemonAPI: NSObject {
   
    @objc(sharedController) static let shared = PokemonAPI()
    
//    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void)
//    
//    @objc func fillInDetails(for pokemon: LSIPokemon)
}
