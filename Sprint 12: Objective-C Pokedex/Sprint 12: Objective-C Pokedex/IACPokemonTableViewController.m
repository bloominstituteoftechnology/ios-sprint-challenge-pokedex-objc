//
//  IACPokemonTableViewController.m
//  Sprint 12: Objective-C Pokedex
//
//  Created by Ivan Caldwell on 3/15/19.
//  Copyright © 2019 Ivan Caldwell. All rights reserved.
//

#import "IACPokemonTableViewController.h"
#import "IACPokemon.h"
#import "IACPokemonDetailViewController.h"
#import "Sprint_12__Objective_C_Pokedex-Swift.h"


@interface IACPokemonTableViewController ()

@end

@implementation IACPokemonTableViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    // I didn't have the right import file "Sprint_12__Objective_C_Pokedex-Swift.h"
    // I wrongfully thought it was #import "Sprint 12: Objective-C Pokedex-Bridging-Header.h"
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<IACPokemon *> * pokemon, NSError * error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return PokemonController.sharedController.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    IACPokemon *pokemon = PokemonController.sharedController.pokemons[indexPath.row];
    cell.textLabel.text = [pokemon.pokemonName capitalizedString];
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemon"]) {
        IACPokemonDetailViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        destinationVC.pokemon = PokemonController.sharedController.pokemons[indexPath.row];
    }
}

@end
