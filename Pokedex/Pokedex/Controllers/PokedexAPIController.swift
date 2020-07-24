//
//  PokedexAPIController.swift
//  Pokedex
//
//  Created by Cody Morley on 7/24/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

@objc
class PokedexAPIController: NSObject {
    //MARK: - Types -
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    //MARK: - Properties -
    @objc static let shared = PokedexAPIController()
    @objc let pokedex = [String]
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    //MARK: - Actions -
    func fetchAllPokemon() {
        let url = getAllURL()
        let request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("There was an error handling your data.")
            }
        }
        
    }
    
    
    //MARK: - Methods -
    private func getAllURL() -> URL {
        let allURL = baseURL.appendingPathComponent("?offset=964&limit=964")
        return allURL
    }
    
    
}

extension PokedexAPIController {
    private struct AllPokemonResult: Codable {
        enum CodingKeys: String, CodingKey {
            case count
            case next
            case previous
            case results
        }
        
        let count: Int
        let next: String
        let previous: String
        let results: [[String : String]]
        
        var usableResults: [String] {
            var names: [String] = []
            
            for result in results {
                let name = result["name"]
                if let name = name {
                    names.append(name)
                }
            }
            return names
        }
    }
}



