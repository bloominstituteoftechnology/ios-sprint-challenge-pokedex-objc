//
//  PokeDetailViewController.swift
//  PokeDex-OBJC
//
//  Created by Joe on 8/29/20.
//  Copyright © 2020 AlphaGradeINC. All rights reserved.
//

import UIKit

class PokemonKVO: NSObject {
    @objc dynamic var pokemon = Pokemon()
}

class PokeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonId: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    @objc let pokemon = Pokemon()
    let formater = NumberFormatter()
    var pokemonToken: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
      pokemonToken = observe(\.pokemon, options: .new) { (strongSelf, change) in
            guard let updatedPokemon = change.newValue else { return }
            strongSelf.pokemonNameLabel.text = updatedPokemon.name
            strongSelf.pokemonId.text = self.formater.string(from: updatedPokemon.identifier)
            strongSelf.pokemonAbilitiesLabel.text = updatedPokemon.abilities[0]
        }
    }
    

}
