//
//  PokemonDetailViewController.swift
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/5/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokemonAPI.addObserver(self, forKeyPath: "pokemon", options: [], context: &KVOContext)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPokemon()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &KVOContext {

            DispatchQueue.main.async {
                self.updateViews()
            }

        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func updateViews() {
        
        guard let pokemon = PokemonAPI.shared.pokemon else { return }
        
        nameLabel.text = "Name: \(pokemon.name.capitalized)"
        idLabel.text = "ID: \(pokemon.identifier!)"
        
        let abilitiesString = pokemon.abilities.map {$0}?.joined(separator: ", ").capitalized
        abilitiesLabel.text = "Abilities: \(abilitiesString!)"
        
        
    }
    
    private func fetchPokemon() {
     
        guard let pokemon = self.pokemon else { return }
        
        PokemonAPI.shared.fillInDetails(for: pokemon)
    }
    

    // MARK: - Properties
    
    @objc var pokemon: Pokemon?
    private var KVOContext = 0
    
    @IBOutlet var pokemonSprite: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var abilitiesLabel: UILabel!
}
