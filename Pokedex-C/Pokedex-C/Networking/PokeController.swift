//
//  PokeController.swift
//  Pokedex-C
//
//  Created by Jeffrey Santana on 10/18/19.
//  Copyright © 2019 Lambda. All rights reserved.
//

import Foundation

@objc class PokeController: NSObject {
	
	private let baseUrl = URL(string: "https://pokeapi.co/api/v2/pokemon")!
	@objc var pokeList = [PokeLink]()
	
	@objc func getPokeList(completion: @escaping (Bool) -> Void) {
		
		var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "964")]
		
		guard let detailsUrl = urlComponents?.url else { return }
		
		URLSession.shared.dataTask(with: detailsUrl) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
				NSLog("Error creating user: \(error)")
				completion(false)
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(false)
				return
			}
			
			do {
				if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
					if let list = json["results"] as? [[String:String]] {
						for pokemon in list {
							self.pokeList.append(PokeLink(dict: pokemon))
						}
						completion(true)
					}
				}
			} catch {
				completion(false)
			}
		}.resume()
	}
	
	@objc func getPokeDetails(from pokeName: String, completion: @escaping (PokeDetails?) -> Void) {
		
		var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
		urlComponents?.path.append(contentsOf: "/\(pokeName)")
		
		guard let detailsUrl = urlComponents?.url else { return }
		
		URLSession.shared.dataTask(with: detailsUrl) { (data, response, error) in
			if let error = error {
				if let response = response as? HTTPURLResponse, response.statusCode != 200 {
					NSLog("Error: status code is \(response.statusCode) instead of 200.")
				}
				NSLog("Error creating user: \(error)")
				completion(nil)
				return
			}
			
			guard let data = data else {
				NSLog("No data was returned")
				completion(nil)
				return
			}
			
			do {
				if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
					let pokemon = PokeDetails(dict: json)
					completion(pokemon)
				}
			} catch {
				completion(nil)
			}
		}.resume()
	}
}
