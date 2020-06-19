//
//  NetworkService.swift
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import Foundation

@objc protocol NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

@objc extension URLSession: NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: request, completionHandler: completion).resume()
    }
}

@objc class NetworkService: NSObject {
    //has to be static to be used as default parameter for createRequest
    //FUTURE: get limit dynamically from https://pokeapi.co/api/v2/pokemon (count property)
    @objc private static let baseURL: URL? = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964")

    ///used to switch between live and Mock Data (also resumes dataTask)
    @objc private var dataLoader: NetworkLoader

    @objc init(dataLoader: NetworkLoader = URLSession.shared) {
        self.dataLoader = dataLoader
    }

    @objc private func createRequest(
        url: URL? = baseURL,
        method: String = "GET"
    ) -> URLRequest? {
        guard let requestUrl = url else {
            NSLog("request URL is nil")
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method
        return request
    }

    @objc private var controller = PokemonController.shared

    @objc private func decodeAllPokemon(data: Data) -> [HSIPokemon]? {
        do {
            let error = NSError(domain: "Decode.NoData", code: 404)
            guard let jsonData = try JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                throw error
            }
            var pokemonArray = [HSIPokemon]()
            if let results = jsonData["results"] as? [[String:String]] {
                for (value) in results {
                    if let name = value["name"],
                        let urlString = value["url"],
                        let url = URL(string: urlString) {
                        let pokemon = HSIPokemon(name: name, url: url)
                        pokemonArray.append(pokemon)
                    }
                }
                return pokemonArray
            } else {
                throw error
            }
        } catch {
            print(error)
        }
        return nil
    }

    @objc func getAllPokemon(completion: @escaping () -> Void = { } ) {
        guard let request = createRequest() else {
            completion()
            return
        }
        dataLoader.loadData(using: request) { [weak self] (data, _, error) in
            guard let self = self else {
                print("\(#file) \(#function) self was nil")
                completion()
                return
            }
            guard let data = data,
                let pokemonArray = self.decodeAllPokemon(data: data)
            else {
                completion()
                return
            }
            self.controller.pokemon = pokemonArray
            completion()
        }

    }
}
