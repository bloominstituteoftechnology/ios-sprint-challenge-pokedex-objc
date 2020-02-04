//
//  PokemonDetailViewController.swift
//  Pokedex-ObjC
//
//  Created by Lambda_School_Loaner_263 on 2/4/20.
//  Copyright © 2020 Lambda_School_Loaner_263. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilityTextView: UITextView!
    
    
    // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    // MARK: - Properties
    var pokemon: PNCPokemon?
    var abilityObservation: NSKeyValueObservation?
    var imageDataObservation: NSKeyValueObservation?
    var idObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokemonAPI.shared.fillInDetails(for: pokemon!)
        
        //PNCPokemon.addObserver(self, forKeyPath: "abilities", options: [], context: nil)
        addObservations()
        nameLabel.text = pokemon?.name
    }
    
    private func addObservations() {
        abilityObservation = pokemon?.observe(\.abilities,options: [.old, .new], changeHandler: { (object, change) in
            
            print("Ability changes from \(String(describing: change.oldValue)) to \(String(describing: change.newValue))")
            
            DispatchQueue.main.async {
                self.abilityTextView.text = self.pokemon?.abilities
            }
        })
        
        imageDataObservation = pokemon?.observe(\.imageData, options: [.old, .new], changeHandler: { (object, change) in
            
            print("ImageData changes from \(String(describing: change.oldValue)) to \(String(describing: change.newValue))")
            
            guard let imageData = self.pokemon?.imageData else { return }
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: imageData)
            }
        })
        
        idObservation = pokemon?.observe(\.pokeId,options: [.old, .new], changeHandler: { (object, change) in
            
            print("ID change from \(String(describing: change.oldValue)) to \(String(describing: change.newValue)))")
            
            DispatchQueue.main.async {
                self.idLabel.text = self.pokemon?.pokeId.stringValue
            }
        })
    }
}
