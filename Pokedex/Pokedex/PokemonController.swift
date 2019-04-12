//
//  PokemonController.swift
//  Pokedex
//
//  Created by Julian A. Fordyce on 4/12/19.
//  Copyright © 2019 Glas Labs. All rights reserved.
//

import Foundation
import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!


class PokemonController: NSObject {
    
    @objc(sharedController) static let shared = PokemonController()
    
    @objc func fetchAllPokemon(completion: @escaping ([GLIPokemon]?, Error?) -> Void) {
        
    }
    
    @objc func fillInDetails(for pokemon: GLIPokemon) {
        
    }
    
    
}
