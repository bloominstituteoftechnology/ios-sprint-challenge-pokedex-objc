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
    @objc var pokedex: [String] = []
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    private lazy var jsonDecoder = JSONDecoder()
    
    //MARK: - Actions -
    @objc func fetchAllPokemon() {
        let url = getAllURL()
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("There was an error with your request. Here's what happened: \(error) \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                NSLog("Couldn't catch 'em all. Pokeball came back empty.")
                return
            }
            
            do {
                let results = try self.jsonDecoder.decode(AllPokemonResult.self, from: data)
                self.pokedex = results.usableResults
            } catch {
                NSLog("Unable to decode incoming data from API. Here's the issue: \(error) \(error.localizedDescription)")
                return
            }
        }.resume()
    }
    
    @objc func fillInDetails(for number: Int) -> CAMPokemon {
        let url = getPokemonByID(number)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                NSLog("There was an error with your request. Here's what happened: \(error) \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                NSLog("Couldn't catch 'em all. Pokeball came back empty.")
                return
            }
            
            do {
                let pokemon = try self.jsonDecoder.decode([].self, from: data)
                NSLog("\(pokemon.name)")
            } catch {
                NSLog("Maybe that wasn't a pokemon? Decoding Error \(error) \(error.localizedDescription)")
                return
            }
        }
    }
    
    
    //MARK: - Methods -
    private func getAllURL() -> URL {
        let allURL = baseURL.appendingPathComponent("?offset=964&limit=964")
        return allURL
    }
    
    private func getPokemonByID(_ id: Int) -> URL {
        let idString = String(id)
        let pokemonURL = baseURL.appendingPathComponent(idString)
        return pokemonURL
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



