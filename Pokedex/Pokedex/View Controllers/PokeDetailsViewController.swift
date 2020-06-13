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
        updateViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
        updateViews()
        updateImage()
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
            isViewLoaded else { return }
        title = pokemon.name.capitalized
        nameLabel.text = "Name: \(pokemon.name.capitalized)"
        idLabel.text = "ID: \(pokemon.identifier ?? 1)"
        abilitiesLabel.text = "Abilities: \(pokemon.abilities.joined(separator: ","))"
        updateImage()
    }
    
    private func updateImage() {
        guard let pokemon = pokemon,
        let pokeAPIClient = pokeAPIClient,
        let spriteURL = pokemon.spriteURL else { return }
            
        
        pokeAPIClient.fetchImage(url: spriteURL) { (result) in
            print(pokemon.spriteURL)
            switch result {
            case .failure(let error):
                print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
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
