//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

@objc class PokemonController: NSObject {

    private enum NetworkError: Error {
        case noData, noDecode, badURL, badData
    }

    var pokemon: [HMRPokemon] = []
    private let baseURL: URL = URL(string: "https://pokeapi.co/api/v2/")!

    // MARK: - Methods

    @objc func fetchPokemon(completion: @escaping ([HMRPokemon]?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("pokemon")

        URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let error = error {
                NSLog("Error receiving data: \(error)")
                completion(nil, error)
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Server did not recognize URL")
                completion(nil, NetworkError.badURL)
                return
            }

            guard let data = data else {
                NSLog("Server did not return Data")
                completion(nil, NetworkError.noData)
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>

                if let array = json["results"] as? [Dictionary<String,String>] {
                    for i in array {
                        let name = i["name"]
                        let newurl = i["detailURL"]
                        let newPokemon = HMRPokemon(name: name!, detailURL: newurl!)
                        self.pokemon.append(newPokemon)
                    }
                }
            } catch {
                NSLog("Failed to do something with json \(error)")
                completion(nil, NetworkError.badData)
            }

            completion(self.pokemon, nil)

        }.resume()
    }


    @objc func fillInDetails(for pokemon: HMRPokemon) {
        let requestURL = URL(string: pokemon.detailURL)!
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            if let error = error {
                NSLog("Error in getting details: \(error)")
                return
            }

            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                NSLog("Not good response")
                return
            }

            guard let data = data else {
                NSLog("Error in data")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>

                if let id = json["id"] as? Int {
                    pokemon.identifier = Int32(id)
                }

                if let sprites = json["sprites"] as? Dictionary<String,Any> {
                    if let frontDefault = sprites["front_default"] as? String {
                        pokemon.image = frontDefault
                    }
                }

                var abilitiesArray: [String] = []

                if let abilities = json["abilities"] as? [Dictionary<String,Any>] {
                    for ability in abilities {
                        if let ability = ability["ability"] as? Dictionary<String,Any> {
                            if let name = ability["name"] as? String {
                                abilitiesArray.append(name)
                            }
                        }
                    }
                }
                pokemon.abilities = abilitiesArray
            } catch {
                NSLog("Error with decoding json serialization: \(error)")

            }
        }
        .resume()

    }

    @objc func fetchImage(with imageURL: String, completion: @escaping (UIImage?, Error?) -> Void) {

        let imageURL = URL(string: imageURL)!

        let request = URLRequest(url: imageURL)

        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error getting request \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else {
                NSLog("No data for image: \(imageURL)")
                completion(nil, error)
                return
            }

            guard let image = UIImage(data: data) else {
                NSLog("Image data is incomplete or not available.")
                completion(nil, error)
                return
            }

            completion(image,nil)

        }.resume()
    }
}
