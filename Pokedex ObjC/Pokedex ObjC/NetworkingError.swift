//
//  NetworkingError.swift
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

enum NetworkingError: Error {
    case noData
    case serverError(Error)
    case unexpectedStatusCode(Int)
    case badDecode
}
