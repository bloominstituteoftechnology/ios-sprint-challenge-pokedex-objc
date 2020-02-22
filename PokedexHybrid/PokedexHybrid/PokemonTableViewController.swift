//
//  PokemonTableViewController.swift
//  PokedexHybrid
//
//  Created by John Kouris on 2/22/20.
//  Copyright © 2020 John Kouris. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    private let reuseIdentifier = "PokemonCell"
    private let detailSegue = "ShowPokemonDetailSegue"
    
    var allPokemon = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let pokemon = allPokemon[indexPath.row]
        cell.textLabel?.text = pokemon.pokemonName.capitalized
        
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == detailSegue {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = allPokemon[indexPath.row]
        }
    }
    
    // MARK: - Private methods
    
    private func fetchPokemon() {
        PokemonController.shared.fetchAllPokemon { (pokemon, error) in
            if let error = error {
                print("Error fetching pokemon: \(error)")
                return
            }
            
            guard let pokemon = pokemon else {
                print("No pokemon")
                return
            }
            
            self.allPokemon.append(contentsOf: pokemon)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}
