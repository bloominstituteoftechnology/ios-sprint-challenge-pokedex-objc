//
//  JDFPokemonTableViewController.m
//  Pokedex
//
//  Created by Jonathan Ferrer on 7/26/19.
//  Copyright © 2019 Jonathan Ferrer. All rights reserved.
//

#import "JDFPokemonTableViewController.h"
#import "JDFPokemon.h"
#import "Pokedex-Swift.h"
#import "JDFPokemonDetailViewController.h"


@interface JDFPokemonTableViewController ()

@property NSArray<JDFPokemon *> *allPokemon;

@end

@implementation JDFPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.allPokemon = [NSArray array];
    [PokemonAPI.shared fetchAllPokemonWithCompletion:^(NSArray<JDFPokemon *> * _Nullable allPokemon, NSError * _Nullable error) {
        self.allPokemon = allPokemon;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allPokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    JDFPokemon *pokemon = self.allPokemon[indexPath.row];
    [cell.textLabel setText:[pokemon.name capitalizedString]];
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    JDFPokemonDetailViewController *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
    JDFPokemon *pokemon = self.allPokemon[indexPath.row];
    [PokemonAPI.shared fillInDetailsFor: pokemon];
    destinationVC.pokemon = pokemon;
}


@end
