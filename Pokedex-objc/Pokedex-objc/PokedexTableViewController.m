//
//  PokedexTableViewController.m
//  Pokedex-objc
//
//  Created by Matthew Martindale on 8/16/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

#import "PokedexTableViewController.h"
#import "Pokedex_objc-Swift.h"
#import "MKMPokemon.h"
#import "DetailViewController.h"

@interface PokedexTableViewController ()

@end

@implementation PokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MKMPokemonAPI.sharedController fetchAllPokemon:^(NSArray<MKMPokemon *> *pokemons, NSError *error) {
        self.pokemons = pokemons;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    MKMPokemon *pokemon = self.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailVC = (DetailViewController *)segue.destinationViewController;
        detailVC.pokemon = self.pokemons[selectedIndexPath.row];
    }
}

@end
