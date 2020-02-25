//
//  LTBPokemonTableViewController.m
//  Pokedex
//
//  Created by Linh Bouniol on 10/12/18.
//  Copyright © 2018 Linh Bouniol. All rights reserved.
//

#import "LTBPokemonTableViewController.h"
#import "LTBPokemon.h"

@interface LTBPokemonTableViewController ()

@end

@implementation LTBPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<LTBPokemon *> *pokemon, NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return PokemonController.sharedController.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    LTBPokemon *pokemon = [PokemonController.sharedController.pokemons objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PokemonDetailViewController *detailVC = [segue destinationViewController];

    if ([detailVC isKindOfClass:[PokemonDetailViewController class]]) {

        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;

        detailVC.pokemon = PokemonController.sharedController.pokemons[indexPath.row];
    }
}


@end
