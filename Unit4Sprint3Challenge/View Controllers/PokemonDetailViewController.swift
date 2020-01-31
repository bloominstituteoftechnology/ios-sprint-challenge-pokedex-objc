//
//  PokemonDetailViewController.swift
//  Unit4Sprint3Challenge
//
//  Created by Jon Bash on 2020-01-31.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!

    var imageObservation: NSKeyValueObservation?
    var idObservation: NSKeyValueObservation?
    var abilitiesObservation: NSKeyValueObservation?

    @objc unowned var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObservers()
        PokemonAPI.shared.fillInDetails(for: pokemon)
        updateViews()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tearDownObservers()
    }

    private func updateViews() {
        nameLabel.text = pokemon.name
        imageView.image = pokemon.sprite
        if let id = pokemon.idNumber {
            idLabel.text = "ID: \(id)"
        }

        guard let abilities = pokemon.abilities else { return }
        var abilityText = ""
        for ability in abilities {
            abilityText = "\(abilityText)\(ability)\n"
        }
        abilityLabel.text = abilityText
    }

    private func setUpObservers() {
        let observerChangeHandler: ((Any, Any) -> Void) = { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.updateViews()
            }
        }

        imageObservation = observe(\.pokemon.sprite, changeHandler: observerChangeHandler)
        idObservation = observe(\.pokemon.idNumber, changeHandler: observerChangeHandler)
        abilitiesObservation = observe(\.pokemon.abilities, changeHandler: observerChangeHandler)
    }

    private func tearDownObservers() {
        imageObservation = nil
        idObservation = nil
        abilitiesObservation = nil
    }
}
