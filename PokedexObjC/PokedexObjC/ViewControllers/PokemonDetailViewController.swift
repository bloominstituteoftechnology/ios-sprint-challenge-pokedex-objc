//
//  PokemonDetailViewController.swift
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @objc var pokemon: FAFPokemon?{
        didSet{
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    func updateViews(){
        
        guard let pokemon = pokemon else {return}
        
        nameLabel.text = pokemon.name
//        idLabel.text = "ID: \(pokemon.pokemonID)"
//        weightLabel.text = "Weight: \(pokemon.weight)"
//        baseXPLabel.text = "BaseX: \(pokemon.baseXP)"
        
        
    }
    
    // MARK: - Properties
    
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var baseXPLabel: UILabel!
    
}
