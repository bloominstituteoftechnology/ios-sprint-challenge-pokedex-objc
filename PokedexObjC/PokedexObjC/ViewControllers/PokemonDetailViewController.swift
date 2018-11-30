//
//  PokemonDetailViewController.swift
//  PokedexObjC
//
//  Created by Farhan on 11/30/18.
//  Copyright © 2018 Farhan. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    @objc var pokemon: FAFPokemon?{
        didSet{
            updateViews()
        }
    }

    func updateViews(){
        
    }

}
