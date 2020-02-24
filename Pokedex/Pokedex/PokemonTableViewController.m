//
//  PokemonTableViewController.m
//  Pokedex
//
//  Created by Bobby Keffury on 2/22/20.
//  Copyright © 2020 Bobby Keffury. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "Pokedex-Swift.h"

@interface PokemonTableViewController ()

@property (nonatomic, readonly) PokemonController *pokemonController;

@end

@implementation PokemonTableViewController


//MARK: - Views

- (void)viewDidLoad {
    [super viewDidLoad];
}

//MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pokemonController.pokemonArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    
    
    return cell;
}


//MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pokemonDetailSegue"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemonController = _pokemonController;
        Pokemon *pokemon = [_pokemonController.pokemonArray objectAtIndex:indexPath.row];
        detailVC.pokemon = [_pokemonController fillInDetailsFor:(pokemon)];
    }
}


@end


//Watch interoperability
//Watch KVO with stopwatch
//Watch Quakes to see the networking in swift
