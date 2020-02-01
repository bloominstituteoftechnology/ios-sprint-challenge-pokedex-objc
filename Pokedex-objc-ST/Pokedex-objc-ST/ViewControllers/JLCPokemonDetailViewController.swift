//
//  JLCViewController.swift
//  Pokedex-objc-ST
//
//  Created by Jake Connerly on 11/15/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class JLCPokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    
    @objc var pokeController: PokeController?
    @objc var pokeName: NSString?
    var pokemon: JLCPokemon?
    var pokeImage: UIImage? {
        didSet {
            updateViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
    }
    
    private func fetchPokemon() {
        guard let pokeController = pokeController,
            let pokeName = pokeName as String? else { return }
        pokeController.fetchSinglePokemon(with: pokeName) { (pokemon, error) in
            if let error = error {
                NSLog("Error when fetching pokemon \(pokeName) in detailview with error:\(error)")
            }
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.fetchPokeImage()
            }
        }
    }
    
    private func fetchPokeImage() {
        guard let pokeController = pokeController,
              let pokemon = pokemon else { return }
        pokeController.fetchImageFromURL(url: pokemon.imageURL) { (image, error) in
            if let error = error {
                NSLog("Error fetching image in detailview with error:\(error)")
                return
            }
            DispatchQueue.main.async {
                self.pokeImage = image
            }
        }
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        title = pokemon.name
        nameLabel.text = "Name: \(pokemon.name)"
        idLabel.text = "ID: \(pokemon.identifier)"
        var abilitiesString = ""
        for ability in pokemon.abilities {
            abilitiesString.append(contentsOf: ability)
        }
        abilitiesTextView.text = abilitiesString
        imageView.image = pokeImage
    }
}
