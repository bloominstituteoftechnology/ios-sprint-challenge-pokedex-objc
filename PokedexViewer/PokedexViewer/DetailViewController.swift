//
//  DetailViewController.swift
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!

    var pokemon: Pokemon?
    var pokemonAPI: PokemonAPI?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    private func updateViews() {
        guard let pokemon = pokemon, let pokemonAPI = pokemonAPI else { return }
        nameLabel.text = "Name: \(pokemon.name)"
        idLabel.text = "ID: \(pokemon.identifier)"

        pokemonAPI.fetchImage(from: pokemon.spriteURLString) { result in
            if let image = try? result.get() {
                DispatchQueue.main.async {
                    self.spriteImageView.image = image
                }
            }
        }
    }
}
