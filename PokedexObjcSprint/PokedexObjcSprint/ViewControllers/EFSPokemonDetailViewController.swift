//
//  EFSPokemonDetailViewController.swift
//  PokedexObjcSprint
//
//  Created by Clayton Watkins on 10/9/20.
//

import UIKit

class EFSPokemonDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    
    // MARK: - Properties
    var spriteObserver: NSKeyValueObservation?
    var idObserver: NSKeyValueObservation?
    var abilitiesObserver: NSKeyValueObservation?
    @objc var pokemon: EFSPokemon? {
        didSet{
            updateViews()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        
        if (pokemon?.identifier == nil) {
            if let pokemon = pokemon {
                EFSPokemonController.shared.fillInDetail(for: pokemon)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserver()
    }
    
    // MARK: - Private Methods
    private func updateViews() {
        if let pokemon = pokemon {
            navigationItem.title = pokemon.name
            imageView.image = pokemon.sprite
            idLabel.text = "ID: \(pokemon.identifier)"
            let abilities = pokemon.abilities as? [String]
            abilityLabel.text = "Abilities: \(String (describing: abilities!.joined(separator: ",").capitalized))"
        }
    }
    
    private func addObserver() {
        let observerChangeHandler: ((Any, Any) -> Void) = { [weak self] _, _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
        
        spriteObserver = observe(\.pokemon?.sprite, changeHandler: observerChangeHandler)
        idObserver = observe(\.pokemon?.identifier, changeHandler: observerChangeHandler)
        abilitiesObserver = observe(\.pokemon?.abilities, changeHandler: observerChangeHandler)
    }
    
    private func removeObserver() {
        spriteObserver = nil
        idObserver = nil
        abilitiesObserver = nil
    }

}
