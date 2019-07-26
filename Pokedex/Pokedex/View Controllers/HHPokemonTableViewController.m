//
//  HHPokemonTableViewController.m
//  Pokedex
//
//  Created by Hayden Hastings on 7/26/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

#import "HHPokemonTableViewController.h"
#import "HHPokemon.h"
#import "HHPokemonDetailViewController.h"
#import "Pokedex-Swift.h"

@interface HHPokemonTableViewController ()

@property (nonatomic, strong) NSArray<HHPokemon *> *allPokemons;
@property (nonatomic, readonly) PokemonController *pokemonController;

@end

@implementation HHPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonController = [PokemonController pokeApi];
    [self.pokemonController fetchPokemonWithCompletion:^(NSArray<HHPokemon *> *allPokemons, NSError *error) {
        if (error) {
            NSLog(@"Error fetching all pokemons");
        }
        dispatch_async(dispatch_get_main_queue(), ^ {
            self.allPokemons = allPokemons;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    HHPokemon *pokemon = self.allPokemons[indexPath.row];
    
    cell.textLabel.text = pokemon.pokeName;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toPokeDetailVC"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        HHPokemonDetailViewController *destinationVC = segue.destinationViewController;
        
        destinationVC.pokemon = self.allPokemons[indexPath.row];
    }
}


@end
