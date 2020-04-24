//
//  KMLPokemonTableViewController.m
//  PokedexObjSprint
//
//  Created by Keri Levesque on 4/24/20.
//  Copyright © 2020 Keri Levesque. All rights reserved.
//

#import "KMLPokemonTableViewController.h"

@interface KMLPokemonTableViewController ()

@property (nonatomic) KMLPokemonController *pokemonController;
@property (nonatomic) NSArray<KMLPokemon *> *pokemons;
@end

@implementation KMLPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pokemonController = [[KMLPokemonController alloc] init];
    
    [self.pokemonController fetchAllPokemonsCompletion:^(NSArray<KMLPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemons = pokemons;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    KMLPokemon *pokemon = self.pokemons[indexPath.row];
    
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailSegue"])
    {
        KMLPokemonDetailViewController *detailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        detailVC.pokemonController = self.pokemonController;
        detailVC.pokemon = [self.pokemons objectAtIndex:indexPath.row];
    }
}


@end
