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
    }
    
    /// Updates the views with the properties of the injected pokemon object
    private func updateViews() {
        guard let pokemon = pokemon else { return }
        networkController?.fillInDetails(for: pokemon)
        title = pokemon.name.capitalized
    }

}
