//
//  BRDPokemonTableViewController.m
//  Pokedex-2
//
//  Created by Bradley Diroff on 6/19/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

#import "BRDPokemonTableViewController.h"
#import "Pokedex_2-Swift.h"
#import "BRDPokemon.h"
#import "BRDPokemonDetailViewController.h"

@interface BRDPokemonTableViewController ()

@property (nonatomic) PokemonAPI *pokemonController;
@property (nonatomic, copy) NSArray<BRDPokemon *> *pokemon;

@end

@implementation BRDPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<BRDPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        
    }];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    BRDPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

- (PokemonAPI *)pokemonController {
    if (!_pokemonController) {
        _pokemonController = [[PokemonAPI alloc] init];
    }
    return _pokemonController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowPokemonSegue"]){
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        BRDPokemonDetailViewController *vc = (BRDPokemonDetailViewController *)segue.destinationViewController;
        vc.pokemonController = self.pokemonController;
        vc.pokemon = self.pokemon[selectedIndexPath.row];}
}


@end
