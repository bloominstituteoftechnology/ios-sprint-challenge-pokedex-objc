//
//  SHPokemonTableTableViewController.m
//  Pokedex
//
//  Created by Sean Hendrix on 3/8/19.
//  Copyright © 2019 Sean Hendrix. All rights reserved.
//

#import "SHPokemonTableViewController.h"
#import "SHPokemonDetailViewController.h"
#import "SHPokemon.h"
#import "Pokedex-Swift.h"

@interface SHPokemonTableViewController ()
@property (nonatomic) NSArray<SHPokemon *> *pokemons;
@end

@implementation SHPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<SHPokemon *> *pokemons, NSError *error) {
        
        self.pokemons = pokemons;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    SHPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
    
    [cell.textLabel setText: pokemon.name];
    
    return cell;
}

- (void)setPokemons:(NSArray<SHPokemon *> *)pokemons
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
        SHPokemonDetailViewController *vc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        SHPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
        
        [vc setPokemon:pokemon];
    }
}

@end
