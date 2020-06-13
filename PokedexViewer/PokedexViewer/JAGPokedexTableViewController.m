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

// TODO: This passing of information needs to be done in KVO

@end
