//
//  PokemonAPI.swift
//  PokedexOBJC
//
//  Created by denis cedeno on 6/12/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

    @objc(sharedController) static let shared: PokemonAPI

    @objc func fetchAllPokemon(completion: @escaping ([LSIPokemon]?, Error?) -> Void)

    @objc func fillInDetails(for pokemon: LSIPokemon)
}
