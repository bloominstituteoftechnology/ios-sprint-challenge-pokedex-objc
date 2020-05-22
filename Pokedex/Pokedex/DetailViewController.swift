//
//  ViewController.swift
//  Pokedex
//
//  Created by Shawn Gee on 5/22/20.
//  Copyright © 2020 Swift Student. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    private static var kvoContext = 0
    
    @objc var pokemon: Pokemon?
    @objc var apiClient: PokeApiClient?
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var idLabel: UILabel!
    @IBOutlet private var abilitiesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKVO()
    }

    // MARK: - Private Methods
    
    private func addKVO() {
        guard let pokemon = pokemon else { return }
        pokemon.addObserver(self, forKeyPath: "abilities", options: .initial, context: &DetailViewController.kvoContext)
    }
    
    private func updateViews() {
        guard let pokemon = pokemon,
              isViewLoaded else { return }
        
        nameLabel.text = "Name: \(pokemon.name)"
        idLabel.text = "ID: \(pokemon.identifier)"
        if let abilities = pokemon.abilities {
            abilitiesLabel.text = "Abilities " + abilities.joined(separator: ", ")
        }
        
        updateImage()
    }
    
    private func updateImage() {
        guard let pokemon = pokemon,
              let spriteURL = pokemon.spriteURL,
              let apiClient = apiClient else { return }
        
        apiClient.fetchImage(url: spriteURL) { (result) in
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
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &DetailViewController.kvoContext, keyPath == "abilities" {
            DispatchQueue.main.async {
                self.updateViews()
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}

