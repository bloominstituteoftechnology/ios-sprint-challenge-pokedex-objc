//
//  CDBPokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

@objc class CDBPokemonDetailViewController: UIViewController {
    
    @objc var pokemon: CDBPokemon? {
        didSet {
            updateViews()
        }
    }
    @objc var pokemonName: NSString?
    @objc var pokemonController: CDBPokemonController?
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemonByName()
    }
    
    private func getPokemonByName() {
        guard let pokemonController = pokemonController, let pokemonName = pokemonName else { return }
        pokemonController.fetchPokemon(withName: pokemonName as String) { (pokemonData, error) in
            if (error != nil) {
                NSLog("Error: fetching pokemon error")
            }
            self.pokemon = pokemonData
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else {
            return
        }
        DispatchQueue.main.async {
            self.title = pokemon.name
            self.nameLabel.text = pokemon.name
            self.idLabel.text = "\(pokemon.identifier)"
            self.abilitiesLabel.text = "\(pokemon.abilities)"
        }
        
    }
}
