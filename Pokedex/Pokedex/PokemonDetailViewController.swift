//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bobby Keffury on 2/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

import UIKit

@objc(PokemonDetailViewController)
class PokemonDetailViewController: UIViewController {

    //MARK: - Properties
    
    @objc var pokemonController: PokemonController?
    @objc var pokemon: PokemonDetail?
    
    //MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    //MARK: - Views
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Methods

    private func updateViews() {
        
    }
}
