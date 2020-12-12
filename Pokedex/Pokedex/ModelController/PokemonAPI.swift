//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Cora Jacobson on 12/12/20.
//

import UIKit

class PokemonAPI: NSObject {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    @objc(sharedController) static let shared = PokemonAPI()

    @objc func fetchAllPokemon(completion: @escaping ([Pokemon]?, Error?) -> Void) {
        
    }

    @objc func fillInDetails(for pokemon: Pokemon) {
        
    }
    
    @objc func fetchImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            if let image = UIImage(data: data) {
                completion(image, nil)
            }
        }
        task.resume()
    }
    
}
