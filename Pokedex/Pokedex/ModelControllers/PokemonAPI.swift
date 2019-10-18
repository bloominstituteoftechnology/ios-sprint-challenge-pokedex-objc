//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Foundation

class PokemonAPI: NSObject {

	private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    @objc(sharedController) static let shared = PokemonAPI()

	@objc func fetchAllPokemon(completion: @escaping ([Pokeman]?, Error?) -> Void) {
		let allPokemonURL = baseURL.appendingPathComponent("pokemon")
		var components = URLComponents(url: allPokemonURL, resolvingAgainstBaseURL: false)
		components?.queryItems = [
			URLQueryItem(name: "offset", value: "0"),
			URLQueryItem(name: "limit", value: "807")
		]
		guard let url = components?.url else { fatalError("couldn't construct URL") }

		URLSession.shared.dataTask(with: url) { data, _, error in
			if let error = error {
				NSLog("Error loading data: \(error)")
				completion(nil, error)
				return
			}

			guard let data = data else {
				NSLog("bad data")
				completion(nil, NSError(domain: "bad data", code: -1, userInfo: nil))
				return
			}

			do {
				let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
				let results = jsonDict?["results"] as? [[AnyHashable: Any]]
				var pokemans = [Pokeman]()
				for result in results ?? [] {
					let pokemon = Pokeman.pokemon(from: result)
					pokemans.append(pokemon)
				}
				completion(pokemans, nil)
			} catch {
				NSLog("Error decoding JSON: \(error)")
				completion(nil, error)
			}
		}.resume()

	}

	@objc func fillInDetails(for pokemon: Pokeman) {

		URLSession.shared.dataTask(with: pokemon.pokeURL) { [weak self] data, _, error in
			if let error = error {
				NSLog("Error loading data: \(error)")
				return
			}

			guard let data = data else {
				NSLog("bad data")
				return
			}

			do {
				let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//				print(jsonDict)
				let sprites: [String: URL]? = (jsonDict?["sprites"] as? [String: Any])?.compactMapValues{
					guard let str = $0 as? String else { return nil }
					return URL(string: str)
				}
				if let imageURL = sprites?["front_default"] {
					self?.fetchImageURL(imageURL, forPokemon: pokemon)
				}

				let abilitiesInfo = jsonDict?["abilities"] as? [[String: Any]]
				for abilityInfo in abilitiesInfo ?? [] {

				}

			} catch {
				NSLog("Error decoding JSON: \(error)")
			}
		}.resume()
	}

	private func fetchImageURL(_ url: URL, forPokemon pokemon: Pokeman) {
		URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
			if let error = error {
				NSLog("Error loading data: \(error)")
				return
			}

			guard let data = data else {
				NSLog("bad data")
				return
			}

			if let image = UIImage(data: data) {
				pokemon.sprite = image
			}
		}.resume()
	}
}
