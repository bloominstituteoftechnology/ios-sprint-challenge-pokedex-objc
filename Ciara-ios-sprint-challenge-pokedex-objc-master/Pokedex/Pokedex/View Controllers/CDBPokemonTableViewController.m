//
//  CDBPokemonTableViewController.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemonTableViewController.h"
#import "Pokedex-Swift.h"
#import "CDBPokemon.h"

@interface CDBPokemonTableViewController ()

@property (nonatomic, strong) CDBPokemonController *pokemonController;
@property (nonatomic, copy) NSArray *pokemons;

@end

@implementation CDBPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokemonController = [CDBPokemonController sharedController];
    [self.pokemonController fetchPokemonsWithCompletion:^(NSArray<CDBPokemon *> *pokemon, NSError *error) {
        if (!pokemon) {
            NSLog(@"Error fetching pokemon: %@", error);
            return;
        }
        self.pokemons = pokemon;
    }];
}

// MARK: Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    CDBPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}

// MARK: Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowPokemonDetailSegue"]) {
        CDBPokemonDetailViewController *pokemonDetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        CDBPokemon *pokemon = self.pokemons[indexPath.row];
        pokemonDetailVC.pokemon = pokemon;
        [self.pokemonController fetchPokemonDetailsWith:pokemon];
    }
}

- (void)setPokemons:(NSArray *)pokemons {
    if (pokemons != _pokemons) {
        _pokemons = [pokemons copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

@end
