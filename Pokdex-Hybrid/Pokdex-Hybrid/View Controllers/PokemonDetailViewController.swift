//
//  PokemonDetailViewController.swift
//  Pokdex-Hybrid
//
//  Created by Isaac Lyons on 12/20/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @objc var pokemonAPI: PokemonAPI?
    @objc var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = pokemon?.name.capitalized
    }

}
