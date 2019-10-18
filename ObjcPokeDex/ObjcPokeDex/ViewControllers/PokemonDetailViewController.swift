//
//  PokemonDetailViewController.swift
//  ObjcPokeDex
//
//  Created by Luqmaan Khan on 10/18/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    @IBOutlet var pokeName: UILabel!
    @IBOutlet var pokeAbilities: UILabel!
    @IBOutlet var pokeID: UILabel!
    @IBOutlet var pokeImage: UIImageView!
    
    @objc var pokemon: LSIPokemon?
    
    var abilityObservation: NSKeyValueObservation?
    var imageObservation: NSKeyValueObservation?
    var pokeIDObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokeName.text = self.pokemon?.name
        PokemonAPI.shared.fillInDetails(for: pokemon!)
        abilityObservation = pokemon?.observe(\.abilites,options: [.old, .new], changeHandler: { (object, change) in
            DispatchQueue.main.async {
                let abilitiesString = self.pokemon?.abilites.map({$0})?.componentsJoined(by: ",")
                self.pokeAbilities.text = abilitiesString
            }
        })
        
        imageObservation = pokemon?.observe(\.spriteURLString,options: [.old, .new], changeHandler: { (object, change) in
            guard let poke = self.pokemon, let url = URL(string:poke.spriteURLString!) else {return}
            PokemonAPI.shared.loadImage(url: url) { (data) in
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.pokeImage.image = image
                }
            }
            
        })
        
        pokeIDObservation = pokemon?.observe(\.id,options: [.old, .new], changeHandler: { (object, change) in
            DispatchQueue.main.async {
                guard let poke = self.pokemon, let id = poke.id else {return}
                self.pokeID.text = "\(id)"
            }
        })
        
    }
    
    
    
}
