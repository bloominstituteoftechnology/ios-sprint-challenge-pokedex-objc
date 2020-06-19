//
//  PokemonDetailViewController.swift
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
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
        
        nameLabel.text = pokemon.name.capitalized
        idLabel.text = String(describing: pokemon.identifier)
        
        if let abilities = pokemon.abilities {
            abilitiesLabel.text = abilities.map { $0.name.capitalized }.joined(separator: "\n")
        }
        
        imageView.image = pokemon.sprite?.image
    }
    
    // MARK: - Properties
    
    private var pokeObservation = [NSKeyValueObservation]()
    
    @objc var pokemon: PDMPokemon? {
        willSet {
            pokeObservation = []
        }
        didSet {
            guard let pokemon = pokemon else { return }
            
            let update = { [weak self] in
                DispatchQueue.main.async { self?.updateViews() }
            }
            pokeObservation.append(pokemon.observe(\.identifier) { (_, _) in update() })
            pokeObservation.append(pokemon.observe(\.abilities) { (_, _) in update() })
            pokeObservation.append(pokemon.observe(\PDMPokemon.sprite?.image) { (_, _) in
                NSLog("Observed")
                update() })
            
        }
    }
}
