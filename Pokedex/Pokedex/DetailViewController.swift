//
//  ViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let apiClient = PokeApiClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        apiClient.fetchAllPokemon { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let pokemon):
                print(pokemon.map { $0.name })
            }
        }
    }


}

