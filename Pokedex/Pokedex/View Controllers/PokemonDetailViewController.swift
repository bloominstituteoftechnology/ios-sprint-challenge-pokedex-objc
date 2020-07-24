//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Joe Veverka on 7/24/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    //MARK: Public Props
    
    @objc var pokemon: Pokemon?
    @objc var apiClient: PokemonAPIClient?
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKVO()
    }
    
    //MARK: IBoutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    // TODO: KVO
    deinit {
        pokemon?.removeObserver(self, forKeyPath: "abilities", context: &PokemonDetailViewController.kvoContext)
    }
    
    private static var kvoContext = 0
    
    private func updateSprite() {
        
        guard let pokemon = pokemon,
            let spriteURL = pokemon.spriteURL,
            let apiClient = apiClient else { return }
        
        apiClient.fetchPokeImage(url: spriteURL) { (result) in
            
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
    
    private func updateViews() {
        
        guard let pokemon = pokemon,
            isViewLoaded else { return }
        
        title = pokemon.name.capitalized
        nameLabel.text = "Name: \(pokemon.name.capitalized)"
        idLabel.text = "ID: \(pokemon.identifier)"
        
        if let abilities = pokemon.abilities {
            
            abilitiesLabel.text = "Abilities: " + abilities.joined(separator: ", ")
            
        }
        
        updateSprite()
        
    }
    
    private func addKVO() {
        
        guard let pokemon = pokemon else { return }
        
        pokemon.addObserver(self, forKeyPath: "abilities", options: .initial, context: &PokemonDetailViewController.kvoContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if context == &PokemonDetailViewController.kvoContext, keyPath == "abilities" {
            
            DispatchQueue.main.async {
                
                self.updateViews()
                
            }
            
        } else {
                
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
           
            }
        }
    }

