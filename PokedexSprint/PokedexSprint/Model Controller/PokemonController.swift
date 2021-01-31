//
//  PokemonController.swift
//  PokedexSprint
//
//  Created by Norlan Tibanear on 1/31/21.
//

import UIKit

enum NetworkError: Error {
    case noData
    case otherError
    case failedJSONDecoder
    case badUrl
}

class PokemonController: NSObject {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    @objc(shareController) static let shared = PokemonController()
    
    var pokemon: [Pokemon] = []
    
    
}// CLASS
