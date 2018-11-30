//
//  FAFPokemonAPI.swift
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

private let baseURL = "https://pokeapi.co/api/v2/pokemon/"

class FAFPokemonAPI: NSObject {

    @objc(sharedController) static let shared = FAFPokemonAPI()
    
    @objc func fetchAllPokemon(completion: @escaping ([FAFPokemon]?, Error?) -> Void)
    {
        
    }
    
    @objc func fillInDetails(for pokemon: FAFPokemon)
    {
        
    }
    
}
