//
//  JGPPokemonTableViewController.m
//  PokedexObjC
//
//  Created by John Pitts on 7/26/19.
//  Copyright © 2019 johnpitts. All rights reserved.
//

#import "JGPPokemonTableViewController.h"
#import "PokedexObjC-Swift.h"
#import "JGPPokemon.h"
#import "JGPDetailViewController.h"

@interface JGPPokemonTableViewController ()

@end

@implementation JGPPokemonTableViewController

- (void)setPokemons:(NSArray<JGPPokemon *> *)pokemons {
    _pokemons = [pokemons copy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [[JGPPokemonAPIController sharedController] fetchAllPokemonWithCompletion:^(NSArray<JGPPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        
        if(error) {
            NSLog(@"Error searching: %@", error);
        }
        self.pokemons = pokemons;
    }];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.pokemons[indexPath.row].name;
    
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"PokemonDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JGPDetailViewController *detailVC = segue.destinationViewController;
        
        JGPPokemon *pokemon = self.pokemons[indexPath.row];
        detailVC.pokemon = pokemon;
        NSLog(@"pokemon selected: %@ \n", pokemon.name);
    }
}


@end
