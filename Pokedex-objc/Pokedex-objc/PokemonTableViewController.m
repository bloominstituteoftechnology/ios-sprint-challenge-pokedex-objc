//
//  PokemonTableViewController.m
//  Pokedex-objc
//
//  Created by Simon Elhoej Steinmejer on 10/12/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "VUKPokemon.h"
#import "Pokedex_objc-Swift.h"
#import "PokemonDetailViewController.h"

@interface PokemonTableViewController ()

@property (nonatomic, strong) NSArray <VUKPokemon *> *pokemon;

@end


@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PokemonController *pc = [PokemonController shared];
    [pc fetchAllPokemonWithCompletion:^(NSArray<VUKPokemon *> *pokemon, NSError *error) {
        self.pokemon = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    }];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    VUKPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if([segue.identifier isEqualToString:@"ShowDetails"]) {
        PokemonDetailViewController *destinationVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        VUKPokemon *pokemon = self.pokemon[indexPath.row];
        destinationVC.pokemon = pokemon;
    }
    
}


@end
