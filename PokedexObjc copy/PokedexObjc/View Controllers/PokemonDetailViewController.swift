//
//  PokemonDetailViewController.swift
//  PokedexObjc
//
//  Created by Alex Rhodes on 11/14/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    var pokemonController = PokemonController.shared
    
    @objc var pokemon: ARPokedexPokemon?
    
    var ARPokemon: ARPokemon?
    
    var pokemonImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pokemon = pokemon else {return}
        pokemonController.fillInDetails(for: pokemon) { (ARpokemon, error) in
            
            if let error = error {
                NSLog("error: \(error)")
            }
            DispatchQueue.main.async {
                guard let ARpokemon = ARpokemon else {return}
                self.ARPokemon = ARpokemon
                
                self.updateViews()
            }
        }
    }
    
    private func updateViews() {
        guard let pokemon = ARPokemon, let id = pokemon.id else { return }
        title = pokemon.name
        idLabel.text = "\(id)"
        
        var abilitiesString = ""
        for ability in pokemon.abilities {
            abilitiesString.append(contentsOf: ability)
        }
        abilitiesLabel.text = abilitiesString
        pokemonImageView.image = pokemonImage
    }
}

