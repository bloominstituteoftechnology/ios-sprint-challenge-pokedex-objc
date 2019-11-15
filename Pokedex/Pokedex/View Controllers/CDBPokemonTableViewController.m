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

@property (nonatomic, nonnull) CDBPokemonController *pokemonController;

@end

@implementation CDBPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[CDBPokemonController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemonController fetchPokemonsWithCompletion:^(NSArray<CDBPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error: Error fetching pokemons on viewDidLoad");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonController.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    CDBPokemon *pokemon = self.pokemonController.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name.capitalizedString;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowPokemonDetailSegue"]) {
        CDBPokemonDetailViewController *pokemonDetailVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        CDBPokemon *pokemon = self.pokemonController.pokemons[indexPath.row];
        pokemonDetailVC.pokemonName = pokemon.name;
        pokemonDetailVC.pokemonController = self.pokemonController;
    }
}

@end
