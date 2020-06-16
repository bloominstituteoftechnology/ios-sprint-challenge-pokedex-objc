//
//  PokemonDetailViewController.swift
//  PokedexOBJC
//
//  Created by denis cedeno on 6/12/20.
//  Copyright © 2020 DenCedeno Co. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @objc var pokemon: DSCPokemon? {
        didSet {
            updateViews()
        }
    }
    
    var pController: PokemonAPI? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var ability1Label: UILabel!
    @IBOutlet weak var ability2Label: UILabel!
    @IBOutlet weak var ability3Label: UILabel!
    
    @IBOutlet weak var abilitytextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
            
    }
    
    func updateViews() {
        guard isViewLoaded else { return }
        guard let detailPokemon = pokemon else {
            title = "No Pokemon Found, Sorry buddy"
            nameLabel.text = ""
            idLabel.text = ""
            ability1Label.text = ""
            ability2Label.text = ""
            ability3Label.text = ""
            return
        }
         
            self.title = detailPokemon.name.capitalized
            self.nameLabel.text = detailPokemon.name
            self.idLabel.text = "\(detailPokemon.pokemonID)"
            self.ability1Label.text = ""
            self.abilitytextView.text = "\(detailPokemon.abilities)"
            self.ability2Label.text = ""
            self.ability3Label.text = ""
            updateImage()
    }
    
    func updateImage() {
        guard let detailPokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.imageView.image = detailPokemon.pokemonSprite
        }
    }
    
    
    
}
