//
//  NetworkingExtensions.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Erica Sadun. All rights reserved.
//

import Foundation

typealias DataResult = Result<Data, NetworkingError>

extension NetworkingError {
    
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
        
        func dataTask(with request: URLRequest, errorHandler: @escaping (NetworkingError?) -> Void) -> URLSessionDataTask {

            self.dataTask(with: request) { _, response, error in
                errorHandler(NetworkingError(error: error, response: response))
            }
        }

        func dataResultTask(with request: URLRequest, resultHandler: @escaping (DataResult) -> Void) -> URLSessionDataTask {
            
            self.dataTask(with: request) { data, response, error in
                
                if let networkError = NetworkingError(error: error, response: response, data: data) {
                        resultHandler(.failure(networkError))
                        return
                    }
                    
                    resultHandler(.success(data!))
            }
        }
    }
    
