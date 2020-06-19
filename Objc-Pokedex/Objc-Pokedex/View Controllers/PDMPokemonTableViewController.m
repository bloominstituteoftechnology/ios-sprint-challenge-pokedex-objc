//
//  PDMPokemonTableViewController.m
//  Objc-Pokedex
//
//  Created by Patrick Millet on 6/19/20.
//  Copyright © 2020 PatrickMillet79. All rights reserved.
//

#import "PDMPokemonTableViewController.h"
#import "PDMPokemon.h"
#import "Objc_Pokedex-Swift.h"

@interface PDMPokemonTableViewController ()

@property (nonatomic, strong) PokemonAPI *pokemonSearchController;
@property (nonatomic, copy) NSArray *pokemon;

@end

@implementation PDMPokemonTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pokemonSearchController = [PokemonAPI sharedController];
    [self.pokemonSearchController fetchAllPokemonWithCompletion:^(NSArray<PDMPokemon *> *pokemon, NSError *error) {
        if (!pokemon) {
            NSLog(@"Error fetching pokemon: %@", error);
            return;
        }
        self.pokemon = pokemon;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    PDMPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PokemonDetailShowSegue"]) {
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PDMPokemon *pokemon = self.pokemon[indexPath.row];
        detailVC.pokemon = pokemon;
        [self.pokemonSearchController pokemonDetailsFor:pokemon];
    }
}

#pragma mark - Properties

- (void)setPokemon:(NSArray *)pokemon
{
    if (pokemon != _pokemon) {
        _pokemon = [pokemon copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

@end
