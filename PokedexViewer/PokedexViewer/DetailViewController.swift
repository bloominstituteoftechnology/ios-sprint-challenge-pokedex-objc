//
//  DetailViewController.swift
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

@objc(JAGDetailViewController)
class DetailViewController: UIViewController {

    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var pokemon: Pokemon? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }

    var observation: NSKeyValueObservation?

    @objc dynamic var pokemonAPI: PokemonAPI = PokemonAPI.shared

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.observe(pokemonAPI: pokemonAPI)
    }

    func observe(pokemonAPI: PokemonAPI) {
        observation = pokemonAPI.observe(\PokemonAPI.pokemon, options: .new) { (pokemonAPI, change) in
            guard let pokemon = change.newValue else { return }
            self.pokemon = pokemon
        }
    }

    deinit {
        observation?.invalidate()
    }

    private func updateViews() {
        guard let pokemon = pokemon else { return }

        nameLabel.text = "Name: \(pokemon.name)"
        idLabel.text = "ID: \(pokemon.identifier)"

        var abilities: String = ""
        for pokemonAbility in pokemon.abilities {
            abilities += "\(pokemonAbility), "
        }

        abilitiesLabel.text = "Abilities: \(abilities)"

        pokemonAPI.fetchImage(from: pokemon.spriteURLString) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.spriteImageView.image = image
                }
            }
        }
    }
}
