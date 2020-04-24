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
    
    @objc(pokemon) static var pokemon: Pokemon? {
        didSet{
            guard let pokemon = pokemon else { return }
            //title = pokemon.name.capitalized
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if nameLabel.text == "Pokemon" {
            
        }
        // Do any additional setup after loading the view.
    }
    
    func updateViews(with pokemon: Pokemon) {
        guard let imageData = try? Data(contentsOf: pokemon.sprite) else { return }
        nameLabel.text = pokemon.name.capitalized
        idLabel.text  = "ID: \(String(describing: pokemon.identifier))"
        guard let image = UIImage(data: imageData) else { return }
        pokemonIV.image = image
        
        var abilities: [String] = []
        
        for newAbility in pokemon.abilities {
            abilities.append(newAbility.capitalized)
        }
        
        abilitiesLabel.text = "Ability: \(abilities.last!)"
    }
    
}
