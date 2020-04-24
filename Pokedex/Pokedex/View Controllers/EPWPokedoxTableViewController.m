//
//  EPWPokedoxTableViewController.m
//  Pokedex
//
//  Created by Elizabeth Wingate on 4/24/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

#import "EPWPokedoxTableViewController.h"
#import "EPWPokemon.h"
#import "Pokedex-Swift.h"
#import "EPWDetailViewController.h"

@interface EPWPokedoxTableViewController ()

@end

@implementation EPWPokedoxTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
        _pokemonAPI = PokemonAPI.sharedController;
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonAPI.pokemonResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    // Configure the cell...
    EPWPokemon *pokemon = self.pokemonAPI.pokemonResults[indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
    if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
                
      EPWDetailViewController *detailVC = (EPWDetailViewController *) [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EPWPokemon *pokemon = self.pokemonAPI.pokemonResults[indexPath.row];
                
        [self.pokemonAPI fillInDetailsFor:pokemon];
        detailVC.pokemon = pokemon;
    }
}

@end
