//
//  PokemonController.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

enum NetworkingError: Error {
    case transportError(Error)
    case badData
    case noData
    case serverError(statusCode: Int)
    case decodingError(Error)
    case encodingError(Error)
}


private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

typealias PokemonResultsCompletion = (Result<[SBAPokemon], NetworkingError>) -> Void
