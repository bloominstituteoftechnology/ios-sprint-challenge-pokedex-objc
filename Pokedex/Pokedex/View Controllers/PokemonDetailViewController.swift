//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Josh Kocsis on 10/9/20.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeName: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeAbilities: UILabel!

    @objc var pokemonController: PokemonNetwork?
    @objc var pokemon: JSKPokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    private func updateViews() {
        guard isViewLoaded else { return }
        guard let pokemon = pokemon else { return }
        getDetails(pokemon.name)
    }

    private func getDetails(_ name: String) {
        pokemonController?.fetchDetails(for: name, completion: { (fetchedPokemon, error) in
            if let error = error {
                print("Couldn't fetch Pokemon: \(error)")
            } else {
                DispatchQueue.main.async {
                    guard let fetchedPokemon = fetchedPokemon else { return }
                    self.pokemon = fetchedPokemon
                    self.pokeName.text = "Name: \(fetchedPokemon.name)"
                    self.pokeID.text = "ID: \(fetchedPokemon.pokemonID)"
                    self.pokeAbilities.text = "Abilities: \(fetchedPokemon.abilities.joined(separator: ", "))"
                    self.fetchImage(fetchedPokemon.sprite)


                }
            }
        })
    }

    private func fetchImage(_ image: String) {
        pokemonController?.fetchImage(image, completion: { (image, error) in
            if let error = error {
                print("Couldn't get image: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.pokeImage.image = image
                }
            }
        })
    }
}
