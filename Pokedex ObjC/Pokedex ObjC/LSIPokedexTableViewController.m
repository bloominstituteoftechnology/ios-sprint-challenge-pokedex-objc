//
//  LSIPokedexTableViewController.m
//  Pokedex ObjC
//
//  Created by macbook on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSIPokedexTableViewController.h"
#import "Pokedex_ObjC-Swift.h"
#import "LSIPokemon.h"
#import "LSIPokemonDetailViewController.h"

@interface LSIPokedexTableViewController ()

@end

@implementation LSIPokedexTableViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
        _pokemonAPI = PokemonAPI.sharedController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemonAPI.pokemonResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    LSIPokemon *pokemon = self.pokemonAPI.pokemonResults[indexPath.row];
    cell.textLabel.text = pokemon.name;
        
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowPokemonDetalsSegue"]) {
        
        LSIPokemonDetailViewController *detailVC = (LSIPokemonDetailViewController *)[segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        LSIPokemon *pokemon = self.pokemonAPI.pokemonResults[indexPath.row];
        
        [self.pokemonAPI fillInDetailsFor:pokemon];
        detailVC.pokemon = pokemon;
    }
}

@end
