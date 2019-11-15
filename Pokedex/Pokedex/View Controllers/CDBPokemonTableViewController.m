//
//  CDBPokemonTableViewController.m
//  Pokedex
//
//  Created by Ciara Beitel on 11/15/19.
//  Copyright © 2019 Ciara Beitel. All rights reserved.
//

#import "CDBPokemonTableViewController.h"
#import "Pokedex-Swift.h"
#import "CDBPokemon.h"

@interface CDBPokemonTableViewController ()

@property (nonatomic, nonnull) CDBPokemonController *pokemonController;

@end

@implementation CDBPokemonTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _pokemonController = [[CDBPokemonController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pokemonController fetchPokemonsWithCompletion:^(NSArray<CDBPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error: Error fetching pokemons on viewDidLoad");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonController.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    CDBPokemon *pokemon = self.pokemonController.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
