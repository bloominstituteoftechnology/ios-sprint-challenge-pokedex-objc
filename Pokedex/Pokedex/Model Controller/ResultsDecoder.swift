//
//  ResultsDecoder.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

protocol ResultDecoder {
    associatedtype ResultType
    
    var transform: (Data) throws -> ResultType { get }
    func decode(_ result: DataResult) -> Result<ResultType, NetworkingError>
    
}

extension ResultDecoder {
    func decode(_ result: DataResult) -> Result<ResultType, NetworkingError> {
        result.flatMap { (data) -> Result<ResultType, NetworkingError> in
            Result {try transform(data) }
                .mapError{ NetworkingError.decodingError($0)}
        }
    }
}
 


