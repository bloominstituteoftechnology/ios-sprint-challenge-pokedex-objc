//
//  JGPPokemonTableViewController.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPPokemonTableViewController.h"

@interface JGPPokemonTableViewController ()

@end

@implementation JGPPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // call pokemonAPIController.fetchAllPokemon(completion ([pokemons], (error)

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0; //pokemonAPIController.pokemons.count
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel = pokemonAPIController.pokemons[indexPath.row].name
    
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue JGPDetailViewController].
    
    // JGPPokemon *pokemon = ?
    // destVC.Pokemon = pokemon;
}


@end
