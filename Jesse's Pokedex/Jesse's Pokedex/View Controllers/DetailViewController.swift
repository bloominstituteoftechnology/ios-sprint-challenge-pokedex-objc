//
//  DetailViewController.swift
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonID: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Properties
    var pokemon: Pokemon?
    var pokemonAbilityObservation: NSKeyValueObservation?
    var pokemonImageObservation: NSKeyValueObservation?
    var pokemonIDObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemon = pokemon else { return }
        PokemonAPI.shared.fillInDetails(for: pokemon)
        pokemonName.text = pokemon.pokemonName
        addObservations()
    }

    private func addObservations() {
        pokemonAbilityObservation = pokemon?.observe(\.pokemonAbilities, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.textView.text = self.pokemon?.pokemonAbilities
            }
        })
        
        pokemonImageObservation = pokemon?.observe(\.sprite, changeHandler: { (object, change) in
            guard let image = self.pokemon?.sprite else { return }
            DispatchQueue.main.async {
                self.pokemonImage.image = UIImage(data: image)
            }
        })
        
        pokemonIDObservation = pokemon?.observe(\.pokemonID, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.pokemonID.text = self.pokemon?.pokemonID.stringValue
            }
        })
    }
}
