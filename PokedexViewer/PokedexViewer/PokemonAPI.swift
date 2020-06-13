//
//  PokemonAPI.swift
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case otherError
    case badData
    case noDecode
}

enum HTTPMethods: String {
    case get = "GET"
}

class PokemonAPI: NSObject {

    @objc(sharedController)
    static let shared = PokemonAPI()

    private let baseURL = URL(string: "https://pokeapi.co/api/v2")
    var pokemon: Pokemon?
    var pokeList: [Pokemon] = []

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        guard let baseURL = baseURL else {
            completion(nil, nil)
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
                let pokemons = try JSONSerialization.jsonObject(with: data, options: []) as? [Pokemon]
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

    }


    func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageURL = URL(string: urlString) else {
            completion(.failure(.otherError))
            return
        }

        var request = URLRequest(url: imageURL)
        request.httpMethod = HTTPMethods.get.rawValue

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }

            guard let data = data else {
                completion(.failure(.badData))
                return
            }

            if let image = UIImage(data: data) {
                completion(.success(image))
            }
        }.resume()
    }

    // Persistence
//    let userDefaults = UserDefaults.standard
//
//    private var pokemonListURL: URL? {
//        let fileManager = FileManager.default
//        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
//        return documents.appendingPathComponent("PokemonList.plist")
//    }
//
//    init() {
//        let userDefault = UserDefaults.standard.bool(forKey: pokemonListKey)
//        // if it's true it means the app has been run before
//        if userDefault {
//            loadFromPersistentStore() // populates array from saved data
//        } else {
//            //           createPokemonList() // creates array
//        }
//    }

//    private func saveToPersistentStore() {
//        guard let url = pokemonListURL else { return }
//
//        do {
//            let encoder = PropertyListEncoder()
//            let listData = try encoder.encode(pokeList)
//            try listData.write(to: url)
//        } catch {
//            print("Error saving shopping list data: \(error)")
//        }
//    }

    // method to load data from the url created when saving the data - this method also checks if the file exists
//    private func loadFromPersistentStore() {
//        let fileManager = FileManager.default
//
//        do {
//            guard let url = pokemonListURL, fileManager.fileExists(atPath: url.path) else { return }
//            let data = try Data(contentsOf: url)
//            let decoder = PropertyListDecoder()
//            let decodedList = try decoder.decode([Pokemon].self, from: data)
//            self.pokeList = decodedList
//        } catch {
//            print("Error loading/decoding shopping list: \(error)")
//        }
//    }
}
