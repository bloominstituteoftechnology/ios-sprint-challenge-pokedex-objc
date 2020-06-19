//
//  PokemonListTableViewController.swift
//  Pokedex_Objective_C
//
//  Created by Kenny on 6/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class PokemonListTableViewController: UITableViewController {

    let controller = PokemonController.shared
    let networkService = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getAllPokemon { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.pokemon?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)

        cell.textLabel?.text = controller.pokemon?[indexPath.row].name.capitalized

        return cell
    }
    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailSegue" {
            guard let selectedCell = tableView.indexPathForSelectedRow else { return }
            guard let destination = segue.destination as? HSIPokemonDetailViewController else { return }
            guard let pokemon = controller.pokemon?[selectedCell.row] else { return }
            destination.pokemon = pokemon
        }
    }

}
