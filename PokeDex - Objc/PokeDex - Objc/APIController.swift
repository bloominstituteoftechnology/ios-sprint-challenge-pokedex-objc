//
//  APIController.swift
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case badData
    case badRequest
    case otherError
    case noURL
    case noDecode
}

class APIController: NSObject {
    
    @objc(sharedController) static let shared = APIController()
    
//    @objc(pokeList) static var pokeList: [Pokemon] = [] {
//        didSet {
//            print("PokeList DidSet")
//        }
//    }
    var pokemon: Pokemon?
    let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
        let url = baseURL.appendingPathComponent("pokemon")
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else { completion(nil, nil)
                return
            }
            
            guard let array = dictionary["results"] as? Array<[String:Any]> else {
                completion(nil, nil)
                return
                
            }
            
            var pokeList = [Pokemon]()
            print(pokeList)
            
            for pokemon in array {
                pokeList.append(Pokemon(dictionary: pokemon))
            }
            completion(pokeList, nil)
        }.resume()
    }

}
