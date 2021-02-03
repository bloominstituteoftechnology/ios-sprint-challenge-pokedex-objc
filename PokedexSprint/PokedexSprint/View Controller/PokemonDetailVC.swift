//
//  PokemonDetailVC.swift
//  PokedexSprint
//
//  Created by Norlan Tibanear on 2/1/21.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // Properties
    @objc var pokemon: Pokemon?
    
    var image: NSKeyValueObservation?
    var name: NSKeyValueObservation?
    var id: NSKeyValueObservation?
    var abilities: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonDetails()
        updateView()
        observer()
    }//
    
    
    func pokemonDetails() {
        guard let pokemon = pokemon else { return }
        PokemonController.shared.pokemonDetail(for: pokemon)
    }
    
    
    func updateView() {
       
        if let  pokemon = pokemon {
            nameLabel.text = pokemon.name
            idLabel.text = "ID: \(pokemon.identifier)"
            let abilities = pokemon.abilities as! [String]
            abilitiesLabel.text = "Abilities: \(String (describing: abilities.joined(separator: ", ")))"
            imageView.image = pokemon.sprite
        }
        
    }//
    
    func observer() {
        let observer: ((Any, Any) -> Void) = { [weak self] _, _ in

            guard let self = self else { return }

            DispatchQueue.main.async {
                self.updateView()
            }
        }

        image = observe(\.pokemon?.sprite, changeHandler: observer)
        id = observe(\.pokemon?.identifier, changeHandler: observer)
        abilities = observe(\.pokemon?.abilities, changeHandler: observer)
    }
    



}//
