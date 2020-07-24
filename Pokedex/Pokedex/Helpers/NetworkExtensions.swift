//
//  NetworkExtensions.swift
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation

typealias DataResult = Result<Data, NetworkError>

extension NetworkError {
    
    init?(error: Error?, response: URLResponse?, data: Data? = Data()) {
        if let error = error {
            self = .transportError(error)
            return
        }

        if let response = response as? HTTPURLResponse,
            !(200...299).contains(response.statusCode) {
            self = .serverError(statusCode: response.statusCode)
            return
        }
        
        if data == nil {
            self = .noData
        }
        
        return nil
    }
}

extension URLSession {
    
    func dataTask(with request: URLRequest, errorHandler: @escaping (NetworkError?) -> Void) -> URLSessionDataTask {

        self.dataTask(with: request) { _, response, error in
            errorHandler(NetworkError(error: error, response: response))
        }
    }

    func dataResultTask(with request: URLRequest, resultHandler: @escaping (DataResult) -> Void) -> URLSessionDataTask {
        
        self.dataTask(with: request) { data, response, error in
            
            if let networkError = NetworkError(error: error, response: response, data: data) {
                    resultHandler(.failure(networkError))
                    return
                }
                
                resultHandler(.success(data!))
        }
    }
}

