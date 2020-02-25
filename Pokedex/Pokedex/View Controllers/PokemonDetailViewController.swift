//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Linh Bouniol on 10/12/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var abilitiesObserver: NSKeyValueObservation?
    
    @objc var pokemon: LTBPokemon? {
        didSet {
            guard let pokemon = pokemon else { return }
            
            updateViews()
            
            abilitiesObserver = pokemon.observe(\LTBPokemon.abilities, changeHandler: { (_, _) in
                // when the property is observed, call updateViews
                self.updateViews()
            })
            
            // Don't need deinit() to remove observer, Swift does it for us
            
            PokemonController.shared.fillInDetails(for: pokemon)
        }
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon, isViewLoaded else { return }
       
        nameLabel.text = "Name: \(pokemon.name)"
        
        if pokemon.identifier != 0 {
            idLabel.text = "ID: \(pokemon.identifier)"
        } else {
            idLabel.text = "ID: Loading..."
        }
        
        abilitiesLabel.text = "Abilities: \(pokemon.abilities?.joined(separator: ", ") ?? "Loading...")"
        
//        imageView.image = pokemon.spriteURL
        if let imageURL = pokemon.spriteURL {
            PokemonController.shared.fetchImage(url: imageURL, completion: { (image, error) in
                if let image = image {
                    self.imageView.image = image
                }
            })
        }
    }
}
