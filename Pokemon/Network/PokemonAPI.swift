//
//  PokemonAPI.swift
//  Pokemon
//
//  Created by Christopher Aronson on 7/26/19.
//  Copyright © 2019 Christopher Aronson. All rights reserved.
//

import Foundation

@objc(KRCPokemonInterface)
class PokemonAPI: NSObject {
    
    // MARK: - Properties
    @objc(sharded) static let shared = PokemonAPI()
    
    // MARK: -  Public Methods
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        print("Fetching All Pokemon...")
    }
}
