//
//  PokemonAPIController.swift
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

import Foundation
import UIKit

private let baseURL = URL(string: "https://pokeapi.co/api/v2/")

@objc(JGPPokemonAPIController)
class PokemonAPIController: NSObject {
    
    @objc(sharedController) static let shared = PokemonAPIController()
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        // appendingPathComponent "pokemon/" to get all the pokemon... url
        
        //URLSession.shared.dataTask(with: url, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
             // .resume()
    }
    
    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
}
