//
//  PokedexTableViewController.m
//  Pokedex
//
//  Created by Andrew Dhan on 10/12/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

#import "AELPokedexTableViewController.h"
#import "AELPokemon.h"
#import "Pokedex-Swift.h"
#import "AELDetailViewController.h"

@interface AELPokedexTableViewController ()

@property NSMutableArray <AELPokemon *> *pokemonList;

@end

@implementation AELPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<AELPokemon *> * _Nullable array, NSError * error) {
        if (error){
            NSLog(@"Error fetching: %@", error);
        }
        self.pokemonList = [array mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    }];
    

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.pokemonList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokeCell" forIndexPath:indexPath];
    
    [[cell textLabel] setText: [[self.pokemonList objectAtIndex:[indexPath row]] name]];
    
    return cell;
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString: @"ShowDetail"]){
        NSInteger index = [[self.tableView indexPathForSelectedRow] row];
        AELDetailViewController *detailVC = (AELDetailViewController *) [segue destinationViewController];
        
        [detailVC setPokemon: [[self pokemonList] objectAtIndex:index]];
    }
}


@end
