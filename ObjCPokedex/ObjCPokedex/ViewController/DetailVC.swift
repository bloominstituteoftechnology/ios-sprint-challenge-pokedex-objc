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
    
    /// Updates the views with the properties of the injected pokemon object
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        networkController?.fillInDetails(for: pokemon)
        title = pokemon.name.capitalized
    }

}
