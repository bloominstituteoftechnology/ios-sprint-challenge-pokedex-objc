//
//  NetworkingEnums.swift
//  Albums
//
//  Created by Shawn Gee on 4/11/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case badData
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

enum HTTPMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let patch = "PATCH"
    static let delete = "DELETE"
}
