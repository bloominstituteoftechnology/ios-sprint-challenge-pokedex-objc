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

	private var abilitiesObserver: NSKeyValueObservation?
	private var spriteObserver: NSKeyValueObservation?

	@objc var pokeman: Pokeman? {
		didSet {
			updateViews()
		}
	}

	deinit {
		abilitiesObserver?.invalidate()
		abilitiesObserver = nil
		spriteObserver?.invalidate()
		spriteObserver = nil
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
		guard let sprite = pokeman.sprite, let abilities = pokeman.abilities else {
			abilitiesObserver?.invalidate()
			abilitiesObserver = pokeman.observe(\Pokeman.abilities) { [weak self] (_, _) in
				DispatchQueue.main.async {
					self?.abilitiesLabel.text = pokeman.abilities?.map{ $0.capitalized }.joined(separator: "\n")
				}
			}
			spriteObserver?.invalidate()
			spriteObserver = pokeman.observe(\Pokeman.sprite) { [weak self] (_, _) in
				DispatchQueue.main.async {
					self?.imageView.image = pokeman.sprite
				}
			}
			PokemonAPI.shared.fillInDetails(for: pokeman)
			return
		}
		abilitiesLabel.text = abilities.map{ $0.capitalized }.joined(separator: "\n")
		imageView.image = sprite
	}

}
