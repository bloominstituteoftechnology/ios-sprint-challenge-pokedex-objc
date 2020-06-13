//
//  PokemonController.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

enum HTTPMethod {
    static let get = "GET"
    static let put = "PUT"
    static let post = "POST"
    static let delete = "DELETE"
}

enum NetworkingError: Error {
    case transportError(Error)
    case badData
    case noData
    case serverError(statusCode: Int)
    case decodingError(Error)
    case encodingError(Error)
}

struct PokemonResultDecoder: ResultDecoder {
    
    typealias ResultType = [SBAPokemon]

    var transform: (Data) throws -> ResultType = { data in
        guard let dict = try JSONSerialization
            .jsonObject(with: data, options: .allowFragments) as? Dictionary<AnyHashable, Any> else {
                throw NetworkingError.decodingError(NSError(domain: "Error decoding pokemon", code: 0))
        }
        guard let results = dict["results"] as? Array<Dictionary<String, String>> else {
            throw NetworkingError.decodingError(NSError(domain: "Error decoding pokemon", code: 0))
        }
        let pokemon = results.map { SBAPokemon(name: $0["name"]!)}
        return pokemon
    }
}

struct ImageResultDecoder: ResultDecoder {
    typealias ResultType = UIImage
    
    var transform: (Data) throws -> UIImage = { data in
        guard let image = UIImage(data: data) else {
            throw NetworkingError.badData
        }
        return image
    }
}


private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

typealias PokemonResultsCompletion = (Result<[SBAPokemon], NetworkingError>) -> Void
typealias ImageResultCompletion = (Result<UIImage, NetworkingError>) -> Void


@objcMembers class PokeApiClient: NSObject {
    
        func fetchSortedPokemon(completion: @escaping ([SBAPokemon]?, Error?) -> Void) {
        self.fetchAllPokemon { (result) in
            switch result {
            case .failure(let error):
                completion(nil, NSError(domain: error.localizedDescription, code: 0))
            case .success(let pokemon):
                completion(pokemon.sorted(by: { $0.name < $1.name }), nil)
            }
    }
}

    // Fetch All Pokemon ( names up to 500)
    func fetchAllPokemon(completion: @escaping PokemonResultsCompletion) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: "500")
        ]
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            completion(PokemonResultDecoder().decode(result))
        }.resume()
    }
    
    
    // Fetch details
    
    @objc func fetchDetails(for pokemon: SBAPokemon) {
        //append pokemon name to url string to get details
        let request = URLRequest(url: baseURL.appendingPathComponent(pokemon.name))
        
        URLSession.shared.dataResultTask(with: request) { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                do {
                    guard let pokeDict = try JSONSerialization
                        .jsonObject(with: data, options: .fragmentsAllowed) as? Dictionary<String, Any> else {
                            throw NetworkingError.decodingError(NSError(domain: "Error decoding pokemon details", code: 0))
                    }
                    self.fillInDetails(for: pokemon, with: pokeDict)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func fillInDetails(for pokemon: SBAPokemon, with pokeDict: Dictionary<String, Any>) {
        if let identifier = pokeDict["id"] as? String { // check back to see if error ( Int or String? )
            pokemon.identifier = identifier
        }
        
        if let imagesDict = pokeDict["sprites"] as? Dictionary<String, String?>,
            let urlString = imagesDict["front_default"] as? String {
            pokemon.spriteURL = URL(string: urlString)!  
        }
        if let abilitiesArray = pokeDict["abilities"] as? Array<Dictionary<String, Any>> {
            let abilities = abilitiesArray.map { (pokeDict) -> String in
                let abilityDict = pokeDict["ability"] as? Dictionary<String,String>
                return abilityDict!["name"]!
            }
            pokemon.abilities = abilities
        }
        
        
    }
    
    func fetchImage(url: URL, completion: @escaping ImageResultCompletion) {
        URLSession.shared.dataResultTask(with: URLRequest(url: url)) { (result) in
            completion(ImageResultDecoder().decode(result))
        }.resume()
    }
    
}
