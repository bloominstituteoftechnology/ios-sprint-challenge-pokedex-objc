//
//  EGCPokedexTableViewController.m
//  Pokedex
//
//  Created by Enrique Gongora on 4/24/20.
//  Copyright © 2020 Enrique Gongora. All rights reserved.
//

#import "EGCPokedexTableViewController.h"

@interface EGCPokedexTableViewController ()

@property (nonatomic) EGCPokemonController *pokemonController;
@property (nonatomic) NSArray<EGCPokemon *> *pokemons;

@end

@implementation EGCPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokemonController = [[EGCPokemonController alloc] init];
    [self.pokemonController fetchAllPokemonsCompletion:^(NSArray<EGCPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemons = pokemons;
            [self.tableView reloadData];
        });
    }];
}

// MARK: - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    EGCPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    return cell;
}

// MARK: - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailSegue"]) {
        EGCPokemonDetailViewController *detailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        detailVC.pokemonController = self.pokemonController;
        detailVC.pokemon = [self.pokemons objectAtIndex:indexPath.row];
    }
}

@end
