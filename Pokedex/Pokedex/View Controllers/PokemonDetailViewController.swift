//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Public Props
    
    @objc var pokemon: Pokemon?
    @objc var apiClient: PokemonAPIClient?
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: IBoutlets
    
    
    // TODO: KVO
    deinit {
        pokemon?.removeObserver(self, forKeyPath: "abilities", context: &PokemonDetailViewController.kvoContext)
    }
}
