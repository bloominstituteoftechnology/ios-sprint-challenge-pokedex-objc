//
//  PokemonTableViewController.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokemonDetailViewController.h"
#import "Pokedex-Swift.h"
#import "Pokemon.h"

@interface PokemonTableViewController ()

@property (nonatomic, readonly) PokemonController *pokemonController;
@property (nonatomic) NSArray<Pokemon *> *pokemon;

@end

@implementation PokemonTableViewController

//MARK: - Views

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonController = [[PokemonController alloc] init];
    
    [_pokemonController fetchPokemonWithCompletion:^(NSArray<Pokemon *> *pokemon, NSError *error) {
        
        if (error) {
            NSLog(@"Error fetching artist: %@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
        }
    }];
    
}

//MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    Pokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}


//MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pokemonDetailSegue"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemonController = _pokemonController;
        Pokemon *pokemon = [_pokemon objectAtIndex:indexPath.row];
        detailVC.pokemonDetail = [_pokemonController fillInDetailsFor:(pokemon)];
    }
}

@end
