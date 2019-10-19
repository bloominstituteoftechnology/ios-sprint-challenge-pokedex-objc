//
//  PokemonAPI.swift
//  Pokedex-Objc
//
//  Created by Marlon Raskin on 10/18/19.
//  Copyright © 2019 Marlon Raskin. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case noToken
    case badURL
    case noData
    case noDecode
    case otherError(Error)
    case badStatusCode
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delet = "DELETE"
}

@objc
class PokemonAPI: NSObject {

    let allPokemonBaseURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964")!
    @objc var allPokemon: [MJRPokemon] = []
    @objc var abilities: [String] = []


    @objc(sharedController) static let shared = PokemonAPI()

    // MARK: - Fetch All Pokemon
    @objc
    func fetchAllPokemon(completion: @escaping ([MJRPokemon]?, Error?) -> Void) {
        var request = URLRequest(url: allPokemonBaseURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                NSLog("Error fetching pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("No data returned from dataTask")
                completion(nil, error)
                return
            }

            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let results = jsonDict["results"] as? [[String: String]] {
                        for pokemon in results {
                            let pokemonObject = MJRPokemon(dictionary: pokemon)
                            self.allPokemon.append(pokemonObject)
                        }
                    }
                    completion(self.allPokemon, nil)
                }
            } catch let error as NSError {
                NSLog("Failed to load pokemon data: \(error)")
                completion(nil, error)
            }
        }.resume()
    }

    // MARK: - Get Pokemon Details
    @objc func fillInDetails(for pokemon: MJRPokemon) {
        guard let urlStr = pokemon.pokemonURL else { return }
        guard let baseURL = URL(string: urlStr) else { return }
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                NSLog("Error fetching pokemon details: \(error)")
                return
            }

            guard let data = data else {
                NSLog("No data returned from dataTask")
                return
            }

            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let abilities = jsonDict["abilities"] as? [[String: Any]],
                        let id = jsonDict["id"] as? Int,
                        let sprites = jsonDict["sprites"] as? [String: Any],
                        let frontSprite = sprites["front_default"] {

                        pokemon.spriteURL = frontSprite as? String
                        pokemon.pokemonID = "\(id)"
                        pokemon.getAbilitiesAsString(abilities)

                        self.fetchSprite(from: frontSprite as? String) { (data, error) in
                            guard let imageData = data else { return }
                            let spriteImage = UIImage(data: imageData)
                            pokemon.pokemonSprite = spriteImage
                        }
                    }
                }
            } catch {
                NSLog("Error decoding json with jsonserialization")
                return
            }
        }.resume()
    }

    // MARK: - Fetch Sprite
    func fetchSprite(from imageURL: String?, completion: @escaping(Data?, Error?) -> Void) {
        guard let imageURLStr = imageURL else { return }
        guard let imageURL = URL(string: imageURLStr) else { return }

        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue

        URLSession.shared.dataTask(with: request) { (imageData, _, error) in

            if let error = error {
                completion(nil, error)
                NSLog("Error fetching image: \(error)")
                return
            }

            guard let data = imageData else {
                completion(nil, error)
                NSLog("No data provided for image: \(imageURL)")
                return
            }
            completion(data, nil)
        }.resume()
    }

}
