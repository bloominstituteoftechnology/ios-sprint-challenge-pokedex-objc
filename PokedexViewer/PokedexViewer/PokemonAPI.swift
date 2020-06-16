//
//  PokemonAPI.swift
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

enum HTTPMethods: String {
    case get = "GET"
}

enum APIError: String, Error {
    case DataNilError
    case JSONDecodeError
    case JSONMissingResults
}

@objc(JAGPokemonAPI)
class PokemonAPI: NSObject {

    @objc(sharedController) static let shared = PokemonAPI()

    private let baseURL = URL(string: "https://pokeapi.co/api/v2")
    var pokemon: Pokemon?
    var pokeList: [Pokemon] = []

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        guard let baseURL = baseURL else {
            completion(nil, NSError())
            return
        }

        let pokeURL = baseURL.appendingPathComponent("pokemon/")
        print(pokeURL)
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethods.get.rawValue

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(nil, error)
                return
            }

            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                completion(nil, error)
            }

            guard let data = data else {
                print("No data was returned from task.")
                completion(nil, error)
                return
            }

            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    else {
                    throw APIError.JSONDecodeError
                }

                guard let pokemonDictionaries = dictionary["results"] as? [[String : Any]] else {
                    throw APIError.JSONMissingResults
                }

                let pokemons = pokemonDictionaries.compactMap{ Pokemon(dictionary: $0)}

                DispatchQueue.main.async {
                    completion(pokemons, nil)
                }
            } catch {
                print("Unable to decode data into pokemon object: \(error)")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
        }.resume()
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        guard let baseURL = baseURL else {
            return
        }

        let pokeURL = baseURL.appendingPathComponent("pokemon/\(pokemon.name)")
        print(pokeURL)
        var request = URLRequest(url: pokeURL)
        request.httpMethod = HTTPMethods.get.rawValue

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data was returned from task.")
                return
            }

            do {
                guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    else {
                        throw APIError.JSONDecodeError
                }

                let pokemon = Pokemon(dictionary: dictionary)

            } catch {
                print("Unable to decode data into pokemon object: \(error)")
                return
            }
        }.resume()
    }

    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NSError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(NSError()))
            return
        }

        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethods.get.rawValue

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(NSError()))
                return
            }

            guard let data = data else {
                completion(.failure(NSError()))
                return
            }

            if let image = UIImage(data: data) {
                completion(.success(image))
            }
        }.resume()
    }
}
