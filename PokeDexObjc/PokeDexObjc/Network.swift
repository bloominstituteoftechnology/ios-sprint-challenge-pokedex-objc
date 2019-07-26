//
//  Network.swift
//  PokeDexObjc
//
//  Created by Michael Flowers on 7/26/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class Network: NSObject {
    static let shared = Network()
    
    func fetchAllPokemon(completion: @escaping ([MRFPokemon]?, Error?) -> Void){
        
    }
    
    func fillInDetails(for pokemon: MRFPokemon){
        
    }
}
