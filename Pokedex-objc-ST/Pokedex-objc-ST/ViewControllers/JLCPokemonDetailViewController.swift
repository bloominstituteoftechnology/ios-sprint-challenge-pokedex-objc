//
//  JLCViewController.swift
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class JLCPokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    
    @objc var pokeController: PokeController?
    @objc var pokeName: NSString?
    var pokemon: JLCPokemon? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
    }
    
    private func fetchPokemon() {
        guard let pokeController = pokeController,
            let pokeName = pokeName as String? else { return }
        pokeController.fetchSinglePokemon(with: pokeName) { (pokemon, error) in
            if let error = error {
                NSLog("Error when fetching pokemon \(pokeName) in detailview with error:\(error)")
            }
            DispatchQueue.main.async {
                self.pokemon = pokemon
            }
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        nameLabel.text = "Name: \(pokemon.name)"
    }
}
