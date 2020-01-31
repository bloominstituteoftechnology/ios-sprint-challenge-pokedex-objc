//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Dennis Rudolph on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var PokeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @objc var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let pokemon = pokemon else { return }
        
        PokemonAPI.shared.fillInDetails(for: pokemon) { (error) in
            if let _ = error {
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    func updateViews() {

        guard let pokemon = pokemon, let id = pokemon.identifier, let abilities = pokemon.abilities, let url = pokemon.spriteURL else { return }
        nameLabel.text = pokemon.name.capitalized
        IDLabel.text = "ID: \(id)"
        var abilitiesString = ""
        for ability in abilities {
            abilitiesString.append(contentsOf: ability)
            abilitiesString.append(" ")
        }
        abilitiesLabel.text = "Abilities: \(abilitiesString.capitalized)"

        let data = try? Data(contentsOf: url)
        if let imageData = data {
            let image = UIImage(data: imageData)
            PokeImageView.image = image
        }
    }
}
