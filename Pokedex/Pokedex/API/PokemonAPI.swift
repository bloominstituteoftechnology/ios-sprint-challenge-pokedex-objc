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
				NSLog("error with JSONSerialization:\(error)")
			}

		}.resume()
	}
	
	@objc func fillInDetails(for pokemon: Pokemon) {
		guard let name = pokemon.name  else { return }
		let url = URL(string: "\(baseUrl)\(name)")!
		print(url)
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if let error = error, let response = response as? HTTPURLResponse{
				NSLog("Error fetching pokedex: \(error)\n Response Code: \(response.statusCode)")
			}
			
			guard let data = data else {
				NSLog("Error fetching data")
				return
			}
//			print(data)
			
			do{
				guard 	let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
					let abilities =  jsonDictionary["abilities"] as? [[String: Any]] else { return }
				
				let sprites = jsonDictionary["sprites"] as! [String: Any]
				let sprite = sprites["front_default"] as! String
				
				pokemon.sprite = sprite
				
				var abilitiesArr: [String] = []
				for i in 0..<abilities.count {
					let ability = abilities[i] as [String: Any]
					let abilityName = ability["ability"] as! [String: Any]
					let name = abilityName["name"] as! String

					abilitiesArr.append(name)
		
				}
				
				pokemon.abilities = abilitiesArr;
			}catch{
				NSLog("error with JSONSerialization:\(error)")
			}
		}.resume()
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
