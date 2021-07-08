//
//  PokemonDetailViewController.swift
//  PokedexObjC
//
//  Created by Benjamin Hakes on 3/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let objectToObserve = objectToObserve else {fatalError(" No object to observe")}
        observation = objectToObserve.observe(\.speciesName) {object,change in
            print("Object Change Observed:\(object):\(change)")
            self.updateViews()
        }
        
        guard let pokemonAPI = pokemonAPI else { fatalError("No pokemonAPI exists.")}
        
        pokemonAPI.fillInDetails(for: objectToObserve)
        
        self.updateViews()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        observation?.invalidate()
    }

    // MARK: Private Methods
    
    func updateViews(){
        
        guard let pokemon = objectToObserve else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.speciesLabel.text = pokemon.speciesName
            self.idLabel.text = pokemon.identifier
            
            guard let images = pokemon.images else { return }
            
            var imageIndex = self.segmentedControl.selectedSegmentIndex
            if imageIndex == 0 {
                imageIndex = 1
            } else {
                imageIndex = 0
            }
            let imageURL = images[imageIndex]
            do {
                let data = try Data(contentsOf: imageURL)
                self.imageView.image = UIImage(data: data)
            } catch {
                print("could not update image view")
            }
            
            guard let abilities = pokemon.abilities else { return }
            
            self.abilitiesTextView.text = ""
            for ability in abilities {
                
                self.abilitiesTextView.text += "\(ability.name)\n"
            }
            
        }
        reloadInputViews()
        
    }
    
    @IBAction func didTapSegmentedControl(_ sender: UISegmentedControl) {
        updateViews()
        
    }
    

    // MARK: Properties
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
   
    @objc var pokemonAPI: PokemonAPI?
    @objc dynamic var observation: NSKeyValueObservation?
    @objc dynamic var objectToObserve: BHPokemon?

}
