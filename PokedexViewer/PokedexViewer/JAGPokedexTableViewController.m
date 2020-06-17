//
//  JAGPokedexTableViewController.m
//  PokedexViewer
//
//  Created by Jessie Ann Griffin on 6/12/20.
//  Copyright © 2020 Jessie Griffin. All rights reserved.
//

#import "JAGPokedexTableViewController.h"
#import "JAGPokemon.h"
#import "PokedexViewer-Swift.h"

@interface JAGPokedexTableViewController ()

@property (nonatomic) NSArray<JAGPokemon *> *pokemons;

@end

@implementation JAGPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [JAGPokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<JAGPokemon *> *pokemons, NSError *error) {
        if (error) {
            NSLog(@"Error fetching list of pokemon: %@", error);
        }
        self.pokemons = pokemons;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    JAGPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier  isEqual:@"ShowDetailSegue"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        JAGPokemon *pokemon = [self.pokemons objectAtIndex:indexPath.row];
        [JAGPokemonAPI.sharedController fillInDetailsFor:pokemon];
    }
}

@end
