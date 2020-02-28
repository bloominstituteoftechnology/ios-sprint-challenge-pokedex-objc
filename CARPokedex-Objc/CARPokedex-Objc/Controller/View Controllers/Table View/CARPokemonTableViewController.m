//
//  CARPokemonTableViewController.m
//  CARPokedex-Objc
//
//  Created by Chad Rutherford on 2/28/20.
//  Copyright © 2020 Chad Rutherford. All rights reserved.
//

#import "CARPokemonTableViewController.h"

@interface CARPokemonTableViewController ()

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Properties
@property (nonatomic) CARPokemonController *pokemonController;

@end

@implementation CARPokemonTableViewController

static NSString *const reuseIdentifier = @"PokemonCell";

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pokemonController = [[CARPokemonController alloc] init];
    [self fetchPokemon];
}

- (void)fetchPokemon {
    [CARPokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<CARPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        [self.pokemonController addPokemonFromArray:pokemon];
        [self.tableView reloadData];
    }];
}

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokemonDetailViewController *detailVC = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CARPokemon *pokemon = self.pokemonController.pokemon[indexPath.row];
    detailVC.pokemon = pokemon;
}

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Table View Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonController.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    CARPokemon *pokemon = self.pokemonController.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

@end
