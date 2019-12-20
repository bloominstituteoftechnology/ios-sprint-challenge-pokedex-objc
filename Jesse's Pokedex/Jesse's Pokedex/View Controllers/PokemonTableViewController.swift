//
//  PokemonTableViewController.swift
//  Jesse's Pokedex
//
//  Created by Jesse Ruiz on 12/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    var allPokemon: [Pokemon] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllPokemon()
    }
    
    // MARK: - Methods
    private func loadAllPokemon() {
        PokemonAPI.shared.fetchAllPokemon { (allPokemon, error) in
            if let error = error {
                NSLog("Error fetching Pokemon: \(error)")
                return
            }
            
            guard let pokemon = allPokemon else {
                NSLog("No Pokemon returning")
                return
            }
            self.allPokemon.append(contentsOf: pokemon)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return allPokemon.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath)

        cell.textLabel?.text = allPokemon[indexPath.row].pokemonName

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            guard let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let pokemon = allPokemon[indexPath.row]
            detailVC.pokemon = pokemon
        }
    }
}
