//
//  PokemonController.swift
//  PokedexObjC
//
//  Created by Harmony Radley on 7/24/20.
//  Copyright © 2020 Harmony Radley. All rights reserved.
//

import UIKit

@objc class PokemonController: NSObject {

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    private enum NetworkError: Error {
        case badResponse
        case badData
        case errorDecoding
    }

    @objc(sharedController) static let shared = PokemonController()
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!

    @objc func fetchAllPokemon(completion: @escaping ([HMRPokemon]?, Error?) -> Void) {

        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            if let error = error {
                completion(nil, error);
                return }

            guard let data = data else {
                completion(nil, nil);
                return }

            guard let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                completion(nil, nil);
                return }
            guard let array = dictionary["results"] as? Array<[String:String]> else {
                completion(nil, nil);
                return }

            var results = [HMRPokemon]()
            for i in array {
                results.append(HMRPokemon(dictionary: i))
            }
            completion(results, nil)
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
                NSLog("Error in getting details response")
                return
            }

            guard let data = data else {
                NSLog("Error in getting details data")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,Any>
                if let id = json["id"] as? Int {
                    pokemon.identifier = Int32(id)
                }

                if let sprites = json["sprites"] as? Dictionary<String,Any> {
                    if let frontDefault = sprites["front_default"] as? String {
                        pokemon.sprite = frontDefault
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
                NSLog("Error decoding json serialization: \(error)")

            }
        }
        .resume()

    }

    @objc func fetchImage(with imageURL: String, completion: @escaping (UIImage?, Error?) -> Void) {

        let imageURL = URL(string: imageURL)!

        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethod.get.rawValue

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
