//
//  VVSPokedexTableViewController.m
//  Pokedex
//
//  Created by Vici Shaweddy on 2/22/20.
//  Copyright © 2020 Vici Shaweddy. All rights reserved.
//

#import "VVSPokedexTableViewController.h"

@interface VVSPokedexTableViewController ()

@property (nonatomic) VVSPokemonController *pokemonController;
@property (nonatomic) NSArray<VVSPokemon *> *pokemons;

@end

@implementation VVSPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pokemonController = [[VVSPokemonController alloc] init];
    
    [self.pokemonController fetchAllPokemonsCompletion:^(NSArray<VVSPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // set the pokemons
            self.pokemons = pokemons;
            // update the UI
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    VVSPokemon *pokemon = self.pokemons[indexPath.row];
    
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        VVSPokemonViewController *detailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        detailVC.pokemonController = self.pokemonController;
        detailVC.pokemon = [self.pokemons objectAtIndex:indexPath.row];
    }
}


@end
