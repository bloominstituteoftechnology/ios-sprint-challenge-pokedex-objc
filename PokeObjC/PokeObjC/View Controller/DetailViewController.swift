//
//  DetailViewController.swift
//  PokeObjC
//
//  Created by Nick Nguyen on 4/24/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK:- Outlets
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeIdLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    //MARK:- Properties
    
    var imageObservation: NSKeyValueObservation?
    var idObservation: NSKeyValueObservation?
    var abilitiesObservation: NSKeyValueObservation?
    
    @objc weak var pokemon: NPTPokemon?
    
    //MARK:- Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        updateViews()

        if (pokemon?.identifier == nil ||  pokemon?.abilities == nil ||  pokemon?.pokemonImage == nil) {
            if let pokemon = pokemon { PokemonAPI.shared.fillInDetails(for: pokemon) }
        }
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeObservers()
    }
    
    // MARK:- Privates
    
    private func updateViews() {
        if let pokemon = pokemon {
            nameLabel.text = pokemon.name.capitalized
            pokemonImageView.image = pokemon.pokemonImage
            pokeIdLabel.text = "ID: \(pokemon.identifier)"
            let abilities = pokemon.abilities as? [String]
            abilitiesLabel.text = "Abilities: \(String(describing: abilities!.joined(separator: ",").capitalized)) "
        }
    }
    private func addObservers() {
        let observerChangeHandler: ((Any, Any) -> Void) = { [weak self] _, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {  self.updateViews()   }
        }
       
        imageObservation = observe(\.pokemon?.pokemonImage, changeHandler: observerChangeHandler)
        idObservation = observe(\.pokemon?.identifier, changeHandler: observerChangeHandler)
        abilitiesObservation = observe(\.pokemon?.abilities, changeHandler: observerChangeHandler)
    }
   
    
    private func removeObservers() {
        imageObservation = nil
        idObservation = nil
        abilitiesObservation = nil
    }

   

}
