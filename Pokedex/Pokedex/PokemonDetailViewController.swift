//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 2/26/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

@objc class PokemonDetailViewController: UIViewController {
    
    //MARK: - Properties
    
    @objc var pokemon: Pokemon?
    var imageObservation: NSKeyValueObservation?
    var idObservation: NSKeyValueObservation?
    var abilityObservation: NSKeyValueObservation?
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: - Methods
    
    private func addObservations() {
        abilityObservation = pokemon?.observe(\.abilities, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.abilitiesTextView.text = self.pokemon?.abilities
            }
        })

        imageObservation = pokemon?.observe(\.sprite, changeHandler: { (object, change) in
            guard let image = self.pokemon?.sprite else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: image)
            }
        })

        idObservation = pokemon?.observe(\.id, changeHandler: { (object, change) in
            DispatchQueue.main.async {
                self.idLabel.text = self.pokemon?.id
            }
        })
    }
    
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        PokemonController.shared.fillInDetails(for: pokemon)
        self.title = pokemon.name.capitalized
        addObservations()
    }

}
