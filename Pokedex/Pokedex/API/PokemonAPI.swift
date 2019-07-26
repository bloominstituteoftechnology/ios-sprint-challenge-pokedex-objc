//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Hector Steven on 7/26/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import Foundation

@objc(HSVPokemonAPI)
class PokemonAPI: NSObject {
	
	@objc(sharedController) static let shared: PokemonAPI = PokemonAPI()
	let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
	
	@objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
		let url = URL(string: "\(baseUrl)?limit=964")!
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error, let response = response as? HTTPURLResponse{
				NSLog("Error fetching pokedex: \(error)\n Response Code: \(response.statusCode)")
				
				completion(nil, error)
			}
			
			guard let data = data else {
				
				completion(nil, NSError())
				return
			}
			
			do{
				guard 	let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
						let results = jsonDictionary["results"] as? [[String: Any]]
					else { return }
				
				let pokedex: [Pokemon] = self.createPokedexWith(results: results)
				completion(pokedex, nil)
				
			}catch {
				NSLog("error with :\(error)")
			}

		}.resume()
		
		
	}
	
	@objc func fillInDetails(for pokemon: Pokemon) {
		
	}
	
	
	func createPokedexWith(results: [[String: Any]]) -> [Pokemon]{
		var pokedex: [Pokemon] = []
		for i in 0..<results.count {
			if let name = results[i]["name"] as? String{
				let pokemon = Pokemon(name: name, identifier: "\(i + 1)")
				pokedex.append(pokemon)
			}
		}
		return pokedex
	}
	
	
}
