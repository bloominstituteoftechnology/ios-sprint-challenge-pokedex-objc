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
        updateViews()
    }
    
    func updateViews() {
        nameLabel.text = pokemon?.name.capitalized
        IDLabel.text = "ID: \(String(describing: pokemon?.identifier))"
        abilitiesLabel.text = "Abilities: \(String(describing: pokemon?.abilities))"
    }
}
