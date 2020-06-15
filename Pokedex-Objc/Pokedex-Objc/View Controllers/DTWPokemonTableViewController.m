//
//  DTWPokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by David Wright on 6/14/20.
//  Copyright © 2020 David Wright. All rights reserved.
//

#import "DTWPokemonTableViewController.h"
#import "DTWPokemonDetailViewController.h"
#import "DTWPokemon.h"
#import "Pokedex_Objc-Swift.h"

@interface DTWPokemonTableViewController ()

@end

@implementation DTWPokemonTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _pokemon = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [DTWPokemonAPI.sharedController fetchAllPokemonWithCompletionHandler:^(NSArray<DTWPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching all pokemon: %@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)pokemonCount
{
    return _pokemon.count;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self pokemonCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    DTWPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    [cell.textLabel setText:pokemon.name];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowPokemonDetailSegue"]) {
        DTWPokemonDetailViewController *pokemonDetailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DTWPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
        
        pokemonDetailVC.pokemon = pokemon;
        pokemonDetailVC.name = pokemon.name;
        pokemonDetailVC.detailsURL = pokemon.detailsURL;
        
        [DTWPokemonAPI.sharedController fillInDetailsForPokemon:pokemon];
    }
}

@end
