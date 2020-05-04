//
//  PokemonDetailViewController.swift
//  PokedexSprintChallengeObjC
//
//  Created by Dillon P on 5/3/20.
//  Copyright © 2020 Dillon's Lambda Team. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesStackView: UIStackView!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @objc dynamic var pokemon: Pokemon?
    @objc dynamic var controller: PokemonController?
    
    var kvoToken: NSKeyValueObservation?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemon = pokemon else { return }
        nameLabel.text = pokemon.name.capitalized
        observe(pokemon: pokemon)
        loadPokemonData()
    }
    
    func observe(pokemon: Pokemon) {
        pokemon.addObserver(self, forKeyPath: "identifier", options: .new, context: nil)
        pokemon.addObserver(self, forKeyPath: "abilities", options: .new, context: nil)
        pokemon.addObserver(self, forKeyPath: "spriteImg", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "identifier", let id = change?[.newKey] {
            DispatchQueue.main.async {
                self.idLabel.text = "ID: \(id)"
            }
        } else if keyPath == "abilities" {
            if let newAbilities = change?[.newKey] as? [String] {
                for ability in newAbilities {
                    DispatchQueue.main.async {
                        let label = UILabel()
                        label.text = ability.capitalized
                        self.abilitiesStackView.addArrangedSubview(label)
                    }
                }
            }
        }
    }
    
    func loadPokemonData() {
        guard let pokemon = pokemon, let controller = controller else { return }
        
        controller.fillInDetails(for: pokemon)
    }
    
    
    

}
