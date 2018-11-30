//
//  MUPokemonTableViewController.m
//  Pokedex
//
//  Created by Moin Uddin on 11/30/18.
//  Copyright © 2018 Moin Uddin. All rights reserved.
//

#import "MUPokemonTableViewController.h"
#import "MUPokemonDetailViewController.h"
#import "MUPokemon.h"
#import "Pokedex-Swift.h"
@interface MUPokemonTableViewController ()
@property (nonatomic) NSArray<MUPokemon *> *pokemons;
@end

@implementation MUPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<MUPokemon *> *pokemons, NSError *error) {
        
        self.pokemons = pokemons;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    MUPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
    
    [cell.textLabel setText: pokemon.name];
    
    return cell;
}

- (void)setPokemons:(NSArray<MUPokemon *> *)pokemons
{
    if (pokemons != _pokemons) {
        _pokemons = [pokemons copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ViewPokemon"]) {
        MUPokemonDetailViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        MUPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
        
        [vc setPokemon:pokemon];
    }
}

@end
