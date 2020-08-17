//
//  PokemonTableViewController.m
//  PokedexObjC
//
//  Created by Sean Acres on 8/16/20.
//  Copyright © 2020 Sean Acres. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "SMAPokemon.h"
#import "PokedexObjC-Swift.h"
#import "PokemonDetailViewController.h"

@interface PokemonTableViewController ()

@property NSArray<SMAPokemon *> *allPokemon;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.sharedController fetchAllPokemonWithCompletion:^(NSArray<SMAPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"error returning all pokemon");
            return;
        }

        self.allPokemon = pokemon;
        dispatch_async(dispatch_get_main_queue(), ^{
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
    
    SMAPokemon *pokemon = [self.allPokemon objectAtIndex:indexPath.row];
    
    cell.textLabel.text = pokemon.name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowPokemonDetailSegue"]) {
        PokemonDetailViewController *pokemonDetailVC = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        pokemonDetailVC.pokemon = [self.allPokemon objectAtIndex:indexPath.row];
        NSLog(@"%@", pokemonDetailVC.pokemon.urlString);
    }
}


@end
