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

- (void)viewDidLoad {
    [super viewDidLoad];
    // I wasted time trying to figure out will PokemonController was being recognize. And
    // all needed to do was build the project....Huhhhhhhh.
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<IACPokemon *> * pokemon, NSError * error) {
        [self.tableView reloadData];
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ShowPokemon"]) {
        IACPokemonDetailViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        destinationVC.pokemon = PokemonController.sharedController.pokemons[indexPath.row];
    }
}


@end
