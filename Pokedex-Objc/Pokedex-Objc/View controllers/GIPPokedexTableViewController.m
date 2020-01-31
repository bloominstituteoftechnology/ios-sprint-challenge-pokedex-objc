//
//  GIPPokedexTableViewController.m
//  Pokedex-Objc
//
//  Created by Gi Pyo Kim on 12/20/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

#import "GIPPokedexTableViewController.h"
#import "GIPDetailViewController.h"
#import "GIPPokemon.h"
#import "Pokedex_Objc-Swift.h"


@interface GIPPokedexTableViewController ()

@property NSArray<GIPPokemon *> *allPokemons;

@end

@implementation GIPPokedexTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<GIPPokemon *> * _Nullable pokemons, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        if (pokemons) {
            self.allPokemons = pokemons;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPokemons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.allPokemons objectAtIndex:indexPath.row].name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [PokemonAPI.sharedController fillInDetailsFor:self.allPokemons[indexPath.row]];
        GIPDetailViewController *detailVC = (GIPDetailViewController *)segue.destinationViewController;
        detailVC.pokemon = self.allPokemons[indexPath.row];
    }
}

@end
