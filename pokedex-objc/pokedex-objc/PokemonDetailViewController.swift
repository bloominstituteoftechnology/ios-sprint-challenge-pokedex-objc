//
//  PokemonDetailViewController.swift
//  pokedex-objc
//
//  Created by Bradley Yin on 10/18/19.
//  Copyright © 2019 bradleyyin. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: BYPokemon?
    var abilityObservation: NSKeyValueObservation?
    var imageDataObservation: NSKeyValueObservation?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokemonAPI.shared.fillInDetails(for: pokemon!)
        addObservations()

        // Do any additional setup after loading the view.
    }
    
    private func addObservations() {
        abilityObservation = pokemon?.observe(\.abilities,options: [.old, .new], changeHandler: { (object, change) in
            print("ability change from \(change.oldValue) to \(change.newValue)")
            
        })
        imageDataObservation = pokemon?.observe(\.imageData,options: [.old, .new], changeHandler: { (object, change) in
            print("imageData change from \(change.oldValue) to \(change.newValue)")
            
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
