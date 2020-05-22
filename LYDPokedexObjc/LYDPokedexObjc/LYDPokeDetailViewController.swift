//
//  LYDPokeDetailViewController.swift
//  LYDPokedexObjc
//
//  Created by Lydia Zhang on 5/22/20.
//  Copyright © 2020 Lydia Zhang. All rights reserved.
//

import UIKit

class LYDPokeDetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var abilitiesTextField: UITextView!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    
    var idObserve: NSKeyValueObservation?
    var abilitiesObserve: NSKeyValueObservation?
    var imageObserve: NSKeyValueObservation?
    deinit {
        idObserve?.invalidate()
        idObserve = nil
        abilitiesObserve?.invalidate()
        abilitiesObserve = nil
        imageObserve?.invalidate()
        imageObserve = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    @objc dynamic var pokemon: LYDPokemon?
    @objc dynamic var netWorking: Networking?
    func setUpViews(){
        guard let pokemon = pokemon, let networking = netWorking else {return}
        
        networking.fetchDetails(for: pokemon)
        idObserve = observe(\.pokemon?.identifier) { [weak self] object, change in
            guard let self = self, let identifier = pokemon.identifier else {return}
            self.idLabel.text = "\(identifier)"
        }
        abilitiesObserve = observe(\.pokemon?.abilities) { [weak self] object, change in
            guard let self = self, let abilities = pokemon.abilities else {return}
            var abilitiesFormatter = " "
            for ability in abilities {
                abilitiesFormatter = "\(ability.capitalized)\n"
            }
            self.abilitiesTextField.text = "\(abilitiesFormatter)"
        }
        imageObserve = observe(\.pokemon?.imageURLStr) { [weak self] object, change in
            guard let self = self else {return}
            guard let imageURL = URL(string: pokemon.imageURLStr) else {return}
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let error = error {NSLog("Error getting image: \(error)")}
                
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {NSLog("\(response)")}
                
                guard let data = data else {return}
                guard let imageData = UIImage(data: data) else {return}
                DispatchQueue.main.async {
                    self.imageView.image = imageData
                }
            }.resume()
        }
    }
    @IBAction func saveTapped(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
