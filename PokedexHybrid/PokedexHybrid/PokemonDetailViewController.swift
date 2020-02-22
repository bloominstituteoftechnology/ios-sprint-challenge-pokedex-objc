//
//  PokemonDetailViewController.swift
//  PokedexHybrid
//
//  Created by John Kouris on 2/22/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView!
    
    var pokemon: Pokemon?
    var abilityObservation: NSKeyValueObservation?
    var imageObservation: NSKeyValueObservation?
    var idObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetails()
    }
    
    private func updateDetails() {
        guard let pokemon = pokemon else { return }
        PokemonController.shared.fillInDetails(for: pokemon)
        pokemonNameLabel.text = pokemon.pokemonName.capitalized
        addObservations()
    }
    
    private func addObservations() {
        abilityObservation = pokemon?.observe(\.pokemonAbilities, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.pokemonAbilitiesTextView.text = self.pokemon?.pokemonAbilities
            }
        })
        
        imageObservation = pokemon?.observe(\.sprite, changeHandler: { (object, change) in
            guard let image = self.pokemon?.sprite else { return }
            DispatchQueue.main.async {
                self.pokemonImageView.image = UIImage(data: image)
            }
        })
        
        idObservation = pokemon?.observe(\.pokemonID, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.pokemonIDLabel.text = self.pokemon?.pokemonID.stringValue
            }
        })
    }

}
