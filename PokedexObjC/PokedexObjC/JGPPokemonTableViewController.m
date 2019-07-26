//
//  JGPPokemonTableViewController.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPPokemonTableViewController.h"
#import "PokedexObjC-Swift.h"
#import "JGPAbility.h"
#import "JGPPokemon.h"

@interface JGPPokemonTableViewController ()

@end

@implementation JGPPokemonTableViewController

- (void)setPokemons:(NSArray<JGPPokemon *> *)pokemons {
    _pokemons = [pokemons copy];
    
    // i don't think we need to reload data here bc we're never really changing list of pokemons, and there's no save button in the DetailViewController
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // call pokemonAPIController.fetchAllPokemon(completion ([pokemons], (error)

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.pokemons[indexPath.row].name;
    
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue JGPDetailViewController].
    
    // JGPPokemon *pokemon = ?
    // destVC.Pokemon = pokemon;
}


@end
