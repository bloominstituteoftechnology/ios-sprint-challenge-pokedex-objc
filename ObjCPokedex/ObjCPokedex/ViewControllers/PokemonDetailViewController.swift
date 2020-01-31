//
//  PokemonDetailViewController.swift
//  ObjCPokedex
//
//  Created by Jerry haaser on 1/31/20.
//  Copyright © 2020 Jerry haaser. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController = PokemonController.shared
    
    @objc var pokemon: JPHPokedexPokemon?
    
    var jphPokemon: JPHPokemon?
    
    var pokemonImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let pokemon = pokemon else { return }
        pokemonController.fillInDetails(for: pokemon) { (JPHpokemon, error) in
            
            if let error = error {
                NSLog("Error: \(error)")
            }
            DispatchQueue.main.async {
                guard let JPHpokemon = JPHpokemon else { return }
                self.jphPokemon = JPHpokemon
                
                self.updateViews()
            }
        }
    }
    
    private func updateViews() {
        guard let pokemon = jphPokemon, let id = pokemon.id else { return }
        self.title = pokemon.name
        idLabel.text = "\(id)"
        
        var abilitiesString = ""
        for ability in pokemon.abilities {
            abilitiesString.append(contentsOf: ability)
        }
        abilitiesLabel.text = abilitiesString
        pokemonImageView.image = pokemonImage
    }
    


}
