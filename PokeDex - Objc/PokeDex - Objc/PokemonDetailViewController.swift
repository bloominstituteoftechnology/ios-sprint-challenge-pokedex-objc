//
//  PokemonDetailViewController.swift
//  PokeDex - Objc
//
//  Created by Ufuk Türközü on 24.04.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokemonIV: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    let apiController: APIController? = nil
    
    @objc var pokemon: Pokemon? {
        didSet{
            guard let pokemon = pokemon else { return }
            title = pokemon.name.capitalized
            getDetails()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemon = pokemon else { return }
        updateViews(with: pokemon)
        // Do any additional setup after loading the view.
    }
    
    func updateViews(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name.capitalized
        idLabel.text  = "ID: \(String(describing: pokemon.identifier))"
        
        print("Abilities: \(pokemon.abilities)")
        var abilities: String = ""
        
        for newAbility in pokemon.abilities {
            abilities.append("\(newAbility.capitalized)")
            if newAbility != pokemon.abilities.last {
                abilities.append(", ")
            }
        }
        
    
        abilitiesLabel.text = "Ability: \(abilities)"
    }
    
    func getDetails() {
        guard let pokemon = pokemon else { return }
        
        APIController.shared.fetchDetails(for: pokemon) { result in
            if let pokemon = try? result.get() {
                DispatchQueue.main.async {
                    
                    APIController.shared.fetchImage(at: pokemon.sprite) { result in
                        if let image = try? result.get() {
                            DispatchQueue.main.async {
                                self.pokemonIV.image = image
                                self.updateViews(with: pokemon)
                            }
                        }
                    }
                }
            }
        }
    }
    
}
