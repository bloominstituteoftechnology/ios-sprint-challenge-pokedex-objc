//
//  PokeDetailsViewController.swift
//  Pokedex
//
//  Created by Sal B Amer on 6/12/20.
//  Copyright © 2020 Sal B Amer. All rights reserved.
//

import UIKit

class PokeDetailsViewController: UIViewController {
    
    // Properties
    @objc var pokemon: SBAPokemon?
    @objc var pokeAPIClient: PokeApiClient?
    
    // Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
