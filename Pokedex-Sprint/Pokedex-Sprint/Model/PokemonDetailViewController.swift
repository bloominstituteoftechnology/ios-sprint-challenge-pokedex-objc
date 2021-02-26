//
//  PokemonDetailViewController.swift
//  Pokedex-Sprint
//
//  Created by Sammy Alvarado on 2/21/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesTextView: UITextView!
    
    @objc var pokemon: Pokemon?
    var pokemonImage: NSKeyValueObservation?
    var pokemonName: NSKeyValueObservation?
    var pokemonID: NSKeyValueObservation?
    var pokemonAbilities: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonDetails()
        updateView()
        pokemonObserver()
        
    }
    
    func pokemonDetails() {
        guard let pokemon = pokemon else { return }
        PokemonController.shared.pokemonDetail(for: pokemon)
    }
    
    func updateView() {
        
        if let pokemon = pokemon {
            pokemonImageView.image = pokemon.sprite
            pokemonNameLabel.text = "Name: \(pokemon.name)"
            pokemonIDLabel.text = "ID: \(pokemon.identifier)"
            
            let abilities = pokemon.abilities as! [String]
            pokemonAbilitiesTextView.text = String(describing: abilities.joined(separator: """


            """))
        }
    }
    
    
    func pokemonObserver() {
        let pokemonObserver: ((Any, Any) -> Void) = { [weak self] _, _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateView()
            }
        }
        
        pokemonImage = observe(\.pokemon?.sprite, changeHandler: pokemonObserver)
        pokemonID = observe(\.pokemon?.identifier, changeHandler: pokemonObserver)
        pokemonAbilities = observe(\.pokemon?.abilities, changeHandler: pokemonObserver)
    }
    
}
