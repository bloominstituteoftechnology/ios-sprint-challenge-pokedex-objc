//
//  TXCPokemonTableViewController.m
//  PokedexObjc
//
//  Created by Thomas Cacciatore on 7/26/19.
//  Copyright © 2019 Thomas Cacciatore. All rights reserved.
//

#import "TXCPokemonTableViewController.h"
#import "TXCPokemon.h"
#import "PokedexObjc-Swift.h"

@interface TXCPokemonTableViewController ()

@end

@implementation TXCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<TXCPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching: %@", error);
        }
        self.pokemons = pokemons;
    }];
}

- (void)setPokemons:(NSArray<TXCPokemon *> *)pokemons {
    _pokemons = [pokemons copy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    TXCPokemon *pokemon = self.pokemons[indexPath.row];
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
