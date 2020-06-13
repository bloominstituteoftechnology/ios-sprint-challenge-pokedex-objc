//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Enayatullah Naseri on 6/12/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    var pokemon: Pokemon?

    // MARK: - Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView!
    
    
    // MARK: - ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - UpdateViews
    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        PokemonController.shared.fillInDetails(for: pokemon)
        pokemonNameLabel.text = pokemon.pokemonName.capitalized
        createObservations()
    }
    

    // MARK: - Arguments
    var observationAb: NSKeyValueObservation?
    var observationIm: NSKeyValueObservation?
    var observationID: NSKeyValueObservation?
    
    
    // MARK: - Observations
    private func createObservations() {
        
        // Ability
        observationAb = pokemon?.observe(\.pokemonAbilities, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.pokemonAbilitiesTextView.text = self.pokemon?.pokemonAbilities
            }
        })
        // Image
        observationIm = pokemon?.observe(\.sprite, changeHandler: { (object, change) in
            guard let image = self.pokemon?.sprite else { return }
            DispatchQueue.main.async {
                self.pokemonImageView.image = UIImage(data: image)
            }
        })
        
        // ID
        observationID = pokemon?.observe(\.pokemonID, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.pokemonIDLabel.text = self.pokemon?.pokemonID.stringValue
            }
        })

    }


}
