//
//  PokemonDetailViewController.swift
//  Pokedex-Obj-C
//
//  Created by scott harris on 4/24/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @objc var pokemon: SAHPokemon!
    var identifierObservation: NSKeyValueObservation?
    var imageDataObservation: NSKeyValueObservation?
    var abilitiesObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        setupObservers()
        PokemonAPI.shared.fillInDetails(for: pokemon)
    }
    
    private func setupObservers() {
        identifierObservation = pokemon.observe(\.identifier, options: .new, changeHandler: { (object, change) in
            self.updateViews()
        })
        
        imageDataObservation = pokemon.observe(\.imageData, options: .new, changeHandler: { (object, change) in
            self.updateViews()
        })
        
        abilitiesObservation = pokemon.observe(\.abilities, options: .new, changeHandler: { (object, change) in
            self.updateViews()
        })

    }
    
    private func updateViews() {
        DispatchQueue.main.async {
            self.nameLabel.text = self.pokemon.name
            
            if let identifer = self.pokemon.identifier {
                self.idLabel.text = identifer.stringValue
            }
            
            if let imageData = self.pokemon.imageData {
                self.imageView.image = UIImage(data: imageData)
            }
            
            if let abilities = self.pokemon.abilities {
                var abilitesString = ""
                for ability in abilities {
                    abilitesString += ability
                    abilitesString += ", "
                }
                
                self.abilitiesLabel.text = abilitesString
            }
        }
        
    }
    
    deinit {
        identifierObservation = nil
        imageDataObservation = nil
        abilitiesObservation = nil
        
    }
    
}
