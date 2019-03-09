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
        
        observation = objectToObserve.observe(\.images, options: [.old, .new], changeHandler: { object, change in
            print("myDate changed from: \(String(describing: change.oldValue!)), updated to: \(String(describing: change.newValue!))")
        })

        updateViews()
    }
    
    // MARK: - Key-Value Observing
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "objectToObserve" {
            // Update Time Label
            print("Yay!")
        }
    }
    
    // MARK: Private Methods
    
    func updateViews(){
        
        guard let pokemon = objectToObserve else { return }
        DispatchQueue.main.async {
            self.nameLabel.text = pokemon.name
            self.speciesLabel.text = pokemon.speciesName
            self.idLabel.text = pokemon.identifier
            
            guard let images = pokemon.images else { return }
            let imageURL = images[self.segmentedControl.selectedSegmentIndex]
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
    private var observation: NSKeyValueObservation?
    @objc dynamic var objectToObserve: BHPokemon! {
        didSet {
            updateViews()
        }
    }

}
