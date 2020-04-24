//
//  PokedexTableViewController.swift
//  PokemonObjC
//
//  Created by Chris Gonzales on 4/24/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var pokemonArray: [CDGPokemon] = []
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
    }
    
    // MARK: - Private Methods
    
    private func fetchPokemon() {
        PokemonAPI.shared.fetchAllPokemon { (pokemonArray, error) in
            if let error = error {
             NSLog("Error fetching pokemon: \(error)")
                return
            }
            
            guard let pokemon = pokemonArray else {
                NSLog("No pokemon")
                return
            }
            self.pokemonArray.append(contentsOf: pokemon)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)


        return cell
    }
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
