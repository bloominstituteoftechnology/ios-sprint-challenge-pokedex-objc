//
//  CDBPokemonDetailViewController.swift
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

import UIKit

@objc class CDBPokemonDetailViewController: UIViewController {
    
    private var pokemonObservations = [NSKeyValueObservation]()
    @objc var pokemon: CDBPokemon? {
        willSet {
            pokemonObservations = []
        }
        didSet {
            guard let pokemon = pokemon else { return }
            
            let update = { [weak self] in
                DispatchQueue.main.async { self?.updateViews() }
            }
            pokemonObservations.append(pokemon.observe(\.identifier) { (_, _) in update() })
            pokemonObservations.append(pokemon.observe(\.abilities) { (_, _) in update() })
            pokemonObservations.append(pokemon.observe(\CDBPokemon.sprite?.image) { (_, _) in
                NSLog("KVO")
                update() })
            
        }
    }
        
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            isViewLoaded else { return }
        nameLabel.text = pokemon.name
        idLabel.text = String(describing: pokemon.identifier)
        spriteImageView.image = pokemon.sprite?.image
        if let abilities = pokemon.abilities {
            abilitiesLabel.text = abilities.map { $0.name }.joined(separator: "\n")
        }
    }
}
