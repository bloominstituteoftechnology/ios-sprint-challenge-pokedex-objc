//
//  DBEDetailViewController.swift
//  PokedexSprint
//
//  Created by Dahna on 7/24/20.
//  Copyright © 2020 Dahna Buenrostro. All rights reserved.
//

import UIKit

class DBEDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var abilityListLabel: UILabel!
    
    var imageObservation: NSKeyValueObservation?
    var idObservation: NSKeyValueObservation?
    var abilitiesObservation: NSKeyValueObservation?
    
    @objc unowned var pokemon: Pokemon!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpObservers()
        updateViews()
        if pokemon.id == nil || pokemon.abilities == nil || pokemon.sprite == nil {
            PokemonAPI.shared.fillInDetails(for: pokemon)
            updateViews()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tearDownObservers()
    }
    
    private func updateViews() {
        
        guard let urlPath = pokemon.spriteURL else { return }
        
        nameLabel.text = "Name: \(pokemon.name.capitalized)"
        spriteImageView.loadSprite(url: urlPath)
        if let id = pokemon.id as? Int {
            idLabel.text = "ID: \(id)"
        }
        
        guard let abilities = pokemon.abilities else { return }
        var abilityText = ""
        for ability in abilities {
            abilityText = "\(abilityText)\(ability.capitalized)\n"
        }
        abilityListLabel.text = abilityText
    }
    
    private func setUpObservers() {
        let observerChangeHandler: ((Any, Any) -> Void) = { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.updateViews()
            }
        }
        
        imageObservation = observe(\.pokemon.spriteURL, changeHandler: observerChangeHandler)
        idObservation = observe(\.pokemon.id, changeHandler: observerChangeHandler)
        abilitiesObservation = observe(\.pokemon.abilities, changeHandler: observerChangeHandler)
    }
    
    private func tearDownObservers() {
        imageObservation = nil
        idObservation = nil
        abilitiesObservation = nil
    }
}

// MARK: - UIImage extension
extension UIImageView {
    func loadSprite(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
