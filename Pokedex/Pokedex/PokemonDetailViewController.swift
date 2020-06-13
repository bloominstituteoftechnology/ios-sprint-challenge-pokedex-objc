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
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UpdateViews
    func updateViews() {
        
        guard let pokemon = pokemon else { return }
        PokemonController.shared.fillInDetails(for: pokemon)
        pokemonNameLabel.text = pokemon.pokemonName.capitalized

    }

    
    // MARK: - Observations
    private func createObservations() {
        

    }


}
