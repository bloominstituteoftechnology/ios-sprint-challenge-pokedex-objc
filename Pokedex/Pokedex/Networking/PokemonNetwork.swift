//
//  PokemonNetwork.swift
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

import Foundation
import UIKit

@objc(PokemonNetwork)
class PokemonNetwork: NSObject {

    @objc func fetchPokemon(completion: @escaping([JSKPokemon]?, NSError?) -> Void) {

        guard let results = URL(string: "https://pokeapi.co/api/v2/pokemon/") else { return }
        var request = URLRequest(url: results)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                print("Couldn't fetch Pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else { return }

            do {
                guard let pokeDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let resultsArray = pokeDictionary["results"] as? [[String: Any]] else { return }
                var pokemon = [JSKPokemon]()
                for dictionary in resultsArray {
                    let pokemons = JSKPokemon(dictionary: dictionary)
                    pokemon.append(pokemons)
                }

                completion(pokemon, nil)

            } catch {

                print("Error decoding: \(error)")
                completion(nil, error as NSError)
                return
            }
        }.resume()
    }

    @objc func fetchPokeImage(forPokemon name: String, completion: @escaping(UIImage?, NSError?) -> Void = {_, _ in}) {

        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(name)

        guard let pokeURL = baseURL else { return }
        var request = URLRequest(url: pokeURL)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                print("Couldn't fetch Pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else { return }

            do {
                guard let pokeDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let pokeSprites = pokeDictionary["sprites"] as? [String: Any],
                      let pokeFront = pokeSprites["front_default"] as? Data else { return }

                let pokeImage = UIImage(data: pokeFront)
                completion(pokeImage, nil)

            } catch {
                print("Error decoding Image: \(error)")
                completion(nil, error as NSError)
            }
        }.resume()
    }


    func fetchDetails(for name: String, completion: @escaping(JSKPokemon?, NSError?) -> Void) {

        let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")?.appendingPathComponent(name)

        guard let pokeURL = baseURL else { return }
        var request = URLRequest(url: pokeURL)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                print("Couldn't fetch Pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else { return }

            do {
                guard let pokeDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                let pokemon = JSKPokemon(dictionary: pokeDictionary)
                completion(pokemon, nil)

            } catch {
                print("Error decoding: \(error)")
                completion(nil, error as NSError)
            }
        }.resume()
    }

    func fetchImage(_ pokeImage: String, completion: @escaping(UIImage?, NSError?) -> Void) {
        
        guard let imageURL = URL(string: pokeImage) else { return }
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error as NSError? {
                print("Couldn't fetch Pokemon: \(error)")
                completion(nil, error)
                return
            }

            guard let data = data else { return }
            let image = UIImage(data: data)
            completion(image, nil)
        }.resume()
    }

}
