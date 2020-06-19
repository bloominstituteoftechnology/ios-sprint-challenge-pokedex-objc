//
//  DetailVC.swift
//  ObjCPokedex
//
//  Created by Shawn James on 6/19/20.
//  Copyright © 2020 Shawn James. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @objc var networkController: NetworkController?
    @objc var pokemon: Pokemon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        addObservers()
    }
    
    private func addObservers() { // KVO
        guard let pokemon = pokemon else { return }
        pokemon.addObserver(self, forKeyPath: "identifier", options: .initial, context: .none)
        pokemon.addObserver(self, forKeyPath: "abilities", options: .initial, context: .none)
        pokemon.addObserver(self, forKeyPath: "image", options: .new, context: .none)
    }
    
    /// Uses the KVO observers to update the UI of whatever has returned
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let pokemon = pokemon else { return }
        switch keyPath {
        case "identifier":
            DispatchQueue.main.async {
                self.idLabel.text = String(self.pokemon!.identifier)
            }
        case "abilities":
            DispatchQueue.main.async {
                let pokemonAbilities = pokemon.abilities as! [String]
                self.abilitiesLabel.text = pokemonAbilities.joined(separator: ", ")
            }
        case "image":
            self.networkController?.loadImage(urlString: pokemon.image, completion: { (pokemonImage, error) in
                DispatchQueue.main.async {
                    self.imageView.image = pokemonImage
                }
            })
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    /// Updates the views with the properties of the injected pokemon object
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        networkController?.fillInDetails(for: pokemon)
        title = pokemon.name.capitalized
    }

}
