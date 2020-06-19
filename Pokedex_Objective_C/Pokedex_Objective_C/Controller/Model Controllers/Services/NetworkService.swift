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
    //has to be static to be used as default parameter for createRequest
    //FUTURE: get limit dynamically from https://pokeapi.co/api/v2/pokemon (count property)
    @objc private static let baseURL: URL? = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=964")

    ///used to switch between live and Mock Data (also resumes dataTask)
    @objc private var dataLoader: NetworkLoader

    @objc init(dataLoader: NetworkLoader = URLSession.shared) {
        self.dataLoader = dataLoader
    }

    @objc func getAllPokemon(data: Data, completion: @escaping (_ pokemonArray: [HSIPokemon]?) -> Void = { _ in }) {
        
    }

    @objc private func createRequest(
        url: URL? = baseURL,
        method: String
    ) -> URLRequest? {
        guard let requestUrl = url else {
            NSLog("request URL is nil")
            return nil
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = method
        return request
    }
}
