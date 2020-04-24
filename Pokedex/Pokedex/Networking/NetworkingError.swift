//
//  NetworkingError.swift
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noData
    case serverError(Error)
    case badDecode
    case unexpectedStatusCode(Int)
}
