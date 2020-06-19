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
    // MARK: - Properties -
    //has to be static to be used as default parameter for createRequest
    //FUTURE: get limit dynamically from https://pokeapi.co/api/v2/pokemon (count property)
    @objc private static let baseURL: URL? = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964")

    ///used to switch between live and Mock Data (also resumes dataTask)
    @objc private var dataLoader: NetworkLoader

    @objc private var controller = PokemonController.shared

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

    @objc func getAllPokemon(completion: @escaping () -> Void = { } ) {
        guard let request = createRequest() else {
            print("\(#file) \(#function) request was nil")
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
                    print("\(#file) \(#function) data was nil")
                    completion()
                    return
            }
            self.controller.pokemon = pokemonArray
            completion()
        }
    }

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

    @objc func getPokemonAbilities(pokemon: HSIPokemon, completion: @escaping () -> Void = { } ) {
        guard let request = createRequest(url: pokemon.url) else {
            print("\(#file) \(#function) request was nil")
            return
        }
        dataLoader.loadData(using: request) { [weak self] (data, _, error) in
            guard let self = self else { return }
            guard let data = data else {
                print("\(#file) \(#function) data was nil")
                completion()
                return
            }
            self.decodePokemonProperties(data: data, pokemon: pokemon)
            completion()
        }
    }

    @objc private func decodePokemonProperties(data: Data, pokemon: HSIPokemon) {
        do {
            let error = NSError(domain: "\(#file) \(#function) Decode.NoData", code: 404)

            guard let jsonData = try JSONSerialization.jsonObject(with: data) as? [String:Any] else {
                throw error
            }
            //get pokemon.identifier
            if let identifier = jsonData["id"] as? Int {
                pokemon.identifier = String(identifier)
            } else {
                throw error
            }
            //get pokemon.abilities
            if let abilities = jsonData["abilities"] as? [[String:Any]] {

                for ability in abilities {
                    if let abilityDictionary = ability["ability"] as? [String:String] {
                        if let name = abilityDictionary["name"] {
                            pokemon.abilities.add(name)
                        }
                    }

                }
            } else {
                throw error
            }
            //get pokemon.image
            if let sprites = jsonData["sprites"] as? [String:Any],
                let sprite = sprites["sprite"] as? String {
                guard let spriteURL = URL(string: sprite) else {
                    throw error
                }
                //TODO: Sprite get method using this URL
            }
        } catch {
            print(error)
        }
    }

}
