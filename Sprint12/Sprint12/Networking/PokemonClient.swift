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
    
    @objc(sharedController) static let shared: PokemonAPI
    
    
    @objc func fetchAllPokemon(completion: @escaping ([DODPokemon]?, Error?) -> Void)
    
    
    @objc func fillInDetails(for pokemon: DODPokemon) {
       
    }

}
