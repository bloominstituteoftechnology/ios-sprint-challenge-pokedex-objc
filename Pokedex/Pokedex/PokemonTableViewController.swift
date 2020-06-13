//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Enayatullah Naseri on 6/12/20.
//  Copyright © 2020 Enayatullah Naseri. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // MARK: - Properties
    var pokemons = [Pokemon]()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokemon()
    }

    // MARK: - Count
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemons.count
    }

    // MARK: - Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        let pokemon = pokemons[indexPath.row]
        cell.textLabel?.text = pokemon.pokemonName.capitalized

        return cell
    }
    
        // MARK: - Fetching data - function
    //    let errorFetch =
        private func fetchPokemon() {
            
            PokemonController.shared.fetchAllPokemon { (pokemon, error) in
                
                if let error = error {
                    print("Error fetching: \(error)")
                    return
                }
                
                guard let pokemon = pokemon else {
                    print("Couldnt find a Pokemon")
                    return
                }
                
                self.pokemons.append(contentsOf: pokemon)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ShowPokemonDetailSegue" {
            guard let destinationVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.pokemon = pokemons[indexPath.row]
        }
        
    }

}
