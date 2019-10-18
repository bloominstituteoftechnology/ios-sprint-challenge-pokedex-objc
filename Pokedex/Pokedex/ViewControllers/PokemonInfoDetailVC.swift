//
//  PokemonInfoDetailVC.swift
//  Pokedex
//
//  Created by Michael Redig on 10/18/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import UIKit

class PokemonInfoDetailVC: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var idlabel: UILabel!
	@IBOutlet weak var abilitiesLabel: UILabel!

	@objc var pokeman: Pokeman? {
		didSet {
			updateViews()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	private func updateViews() {
		loadViewIfNeeded()
		guard let pokeman = pokeman else { return }
		nameLabel.text = pokeman.name
		idlabel.text = "\(pokeman.identifier)"
		abilitiesLabel.text = "loading"
		guard let imageURL = pokeman.spriteURL else {
			PokemonAPI.shared.fillInDetails(for: pokeman)
			return
		}
	}

}
