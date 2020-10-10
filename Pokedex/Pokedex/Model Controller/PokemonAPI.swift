//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Bronson Mullens on 10/9/20.
//

import UIKit

class PokemonAPI: NSObject {
    
    // MARK: - Properties
    
    @objc(sharedController) static let shared = PokemonAPI()
    @objc dynamic var pokemonSprite: UIImage?
    @objc dynamic var pokemon: BRMPokemon? {
        didSet {
            guard let spriteURL = pokemon?.sprite else { return }
            PokemonAPI.shared.fetchSprite(url: spriteURL)
        }
    }
    
    var pokedex: [BRMPokemon] = []
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    // MARK: - OBJC Network Methods
    
    @objc func fetchAllPokemon(completion: @escaping ([BRMPokemon]?, Error?) -> Void) {
        
        let url = fetchURL(searchTerm: "")
        
        fetch(url: url) { (dictionary, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                return
            }
            
            guard let dictionary = dictionary else { return }
            
            guard let pokemonDictionaries = dictionary["results"] as? [[String: String]] else { return }
            
            // Populates pokedex
            for dictionary in pokemonDictionaries {
                if let pokemon = BRMPokemon(dictionary: dictionary) {
                    self.pokedex.append(pokemon)
                }
            }
            completion(self.pokedex, nil)
        }
    }
    
    
    @objc func fillInDetails(for pokemon: BRMPokemon) {
        // Clears last set pokemon
        self.pokemon = nil
        
        guard let url = pokemon.pokemonURL else { return }
        
        fetch(url: url) { (dictionary, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let dictionary = dictionary else { return }
            
            let expectedPokemon = BRMPokemon(dictionary: dictionary)
            
            guard let realPokemon = expectedPokemon else { return }
            
            self.pokemon = realPokemon
        }
        
    }
    
    // MARK: - Private Network Methods
    
    private func fetchSprite(url: URL) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            self.pokemonSprite = image
        }.resume()
    }
    
    private func fetch(url: URL, session: URLSession = URLSession.shared, completion: @escaping ([String: Any]?, Error?) -> Void) { session.dataTask(with: url) { (data, _, error) in
        if let error = error {
            print(error.localizedDescription)
            completion(nil, error)
            return
        }
        
        guard let data = data else { return }
        
        do {
            let decodedDictionary = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let dictionary = decodedDictionary as? [String: Any] else {
                print("Dictionary mismatch")
                completion(nil, NSError())
                return
            }
            completion(dictionary, nil)
            return
        } catch {
            print(error.localizedDescription)
            completion(nil, error)
            return
        }
    }.resume()
    }
    
    private func fetchURL(searchTerm: String) -> URL {
        var url = baseURL
        if !searchTerm.isEmpty {
            url.appendPathComponent(searchTerm)
        } else {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            // Limits the # of pokemon returned, 151 would only include generation 1
            let limitItem = URLQueryItem(name: "limit", value: "151")
            components.queryItems = [limitItem]
            url = components.url!
        }
        return url
    }
    
}
