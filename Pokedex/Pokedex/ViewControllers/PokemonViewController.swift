//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by brian vilchez on 1/31/20.
//  Copyright © 2020 brian vilchez. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {

    //MARK: - properties
    @objc var pokemonController: PokemonController?
    @objc var pokemon: BVPokemon?
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var PokemonID: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
   private func updateViews() {
    guard isViewLoaded else { return }
    guard let pokemon = pokemon else { return }
    guard let name = pokemon.name else { return }
    title = pokemon.name
    pokemonName.text = pokemon.name
    getPokemon(withName: name)
    

    }
    
    
    //MARK: - helper methods
    
    private func getPokemon(withName name: String) {
    pokemonController?.getPokemon(withName: name, completion: { (pokemon, error) in
        if let error = error {
            NSLog("error fetching pokemon: \(error)")
    } else {
        DispatchQueue.main.async {
                     self.pokemon = pokemon
                     guard let pokemon = pokemon else { return }
                     self.PokemonID.text = "\(pokemon.pokemonID)"
                     guard let sprite = pokemon.sprite else { return }
                     self.getImage(sprite)
                 }
             }
         })
        
    }
    
    private func getImage(_ sprite: String){
    self.pokemonController?.getimage(sprite, completion: { (image, error) in
        if let error = error as NSError? {
            NSLog("error getting data: \(error)")
        }
        DispatchQueue.main.async {
            guard let image = image else { return }
            self.pokemonImage.image = image
                }
                        
            })
        
    }
}
