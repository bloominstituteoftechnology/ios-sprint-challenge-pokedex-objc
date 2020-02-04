//
//  PokemonTableViewController.swift
//  Pokedex-ObjC
//
//  Created by Lambda_School_Loaner_263 on 2/4/20.
//  Copyright © 2020 Lambda_School_Loaner_263. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    // MARK: - Properties
    var pokemons: [PNCPokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPokemon()
    }
    
    // -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    // MARK: - Methods
    private func loadPokemon() {
           
           PokemonAPI.shared.fetchAllPokemon { (pokemons, error) in
               if let error = error {
                   print("Error fetching pokemon in view controller: \(error)")
                   return
               }
               
               guard let pokemons = pokemons else {
                   print("No pokemons was returned")
                   return
               }
               
               self.pokemons.append(contentsOf: pokemons)
               print(pokemons)
               DispatchQueue.main.async {
                   self.tableView.reloadData()
               }
           }
       }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
    
       cell.textLabel?.text = pokemons[indexPath.row].name
    
    return cell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height) {
            print("end")
            loadPokemon()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "ShowPokemonDetailSegue" {
            guard let detailVC = segue.destination as? PokemonDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let pokemon = pokemons[indexPath.row]
            detailVC.pokemon = pokemon
        }
     }

}
