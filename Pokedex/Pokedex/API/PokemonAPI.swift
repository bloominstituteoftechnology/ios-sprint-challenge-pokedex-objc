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
			
			
			print(data)
			
			
			
			
		}.resume()
		
		
	}
	
	@objc func fillInDetails(for pokemon: Pokemon) {
		
	}
}
