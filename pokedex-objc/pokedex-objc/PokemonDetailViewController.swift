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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        PokemonAPI.shared.fillInDetails(for: pokemon!)
        
        BYPokemon.addObserver(self, forKeyPath: "abilities", options: [], context: nil)

        // Do any additional setup after loading the view.
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(keyPath)
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
