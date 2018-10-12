//
//  SMFPokedexTableViewController.m
//  Pokedex ObjC
//
//  Created by Samantha Gatt on 10/12/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

#import "SMFPokedexTableViewController.h"
#import "SMFPokemonDetailViewController.h"
#import "SMFPokemon.h"
#import "Pokedex_ObjC-Swift.h"


@interface SMFPokedexTableViewController ()

@property SMFPokemonController *pokemonController;

@end

@implementation SMFPokedexTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemon];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokemonController.pokemons.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    SMFPokemon *pokemon = self.pokemonController.pokemons[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ShowPokemonDetail"]) {
        SMFPokemonDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        SMFPokemon *pokemon = self.pokemonController.pokemons[indexPath.row];
        destination.pokemon = pokemon;
        destination.pokemonController = self.pokemonController;
    }
}

@end
