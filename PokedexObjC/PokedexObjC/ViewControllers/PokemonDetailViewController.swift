//
//  PokemonDetailViewController.swift
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let pokemonName = pokemonName else { fatalError("No pokemon sent to detail View Controller")}
        guard let pokemonController = pokemonController else { fatalError("No pokemonController sent to detail View Controller")}
        
        pokemonController.getPokemon(name: pokemonName) { (pokemon, error) in
            
            self.pokemon = pokemon
            
        }
        
    }
    
    // MARK: Private Methods
    
    func updateViews(){
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.speciesLabel.text = pokemon.speciesName
            self.idLabel.text = pokemon.identifier
        }
        
    }
    
    
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @objc var pokemonName: String?
    @objc var pokemonController: PokemonController?
    var pokemon: BHPokemon? {
        didSet {
            updateViews()
        }
    }

}
