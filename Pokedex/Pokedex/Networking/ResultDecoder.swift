//
//  ResultDecoder.swift
//  Albums
//
//  Created by Shawn Gee on 4/13/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

protocol ResultDecoder {
    
    associatedtype ResultType
    
    var transform: (Data) throws -> ResultType { get }
    
    func decode(_ result: DataResult) -> Result<ResultType, NetworkError>
}

extension ResultDecoder {
    func decode(_ result: DataResult) -> Result<ResultType, NetworkError> {
        result.flatMap { data -> Result<ResultType, NetworkError> in
            Result { try transform(data) }
                .mapError { NetworkError.decodingError($0) }
        }
    }
}

//struct CalorieEntryResultDecoder: ResultDecoder {
//    typealias ResultType = [String: CalorieEntryRepresentation]
//
//    var transform = { data in
//        try JSONDecoder().decode([String: CalorieEntryRepresentation].self, from: data)
//    }
//}
