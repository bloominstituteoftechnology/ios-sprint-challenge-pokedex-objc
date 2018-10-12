//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 10/12/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemonController: PokemonController?
    
    @objc var pokemon: LTBPokemon?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
