//
//  LSIPokedexTableViewController.m
//  Pokedex
//
//  Created by Alex on 7/26/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "LSIPokedexTableViewController.h"
#import "LSIDetailViewController.h"
#import "LSIPokemon.h"
//#import "Pokedex-Bridging-Header.h"
#import "Pokedex-Swift.h" //bridging header

@interface LSIPokedexTableViewController ()

@property (nonatomic) NSArray<LSIPokemon *> *allPokemon;

@end

@implementation LSIPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LSIPokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<LSIPokemon *> *allPokemon, NSError *error) {
        self.allPokemon = allPokemon;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Detail Segue"]) {
        LSIDetailViewController *destinationVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        LSIPokemon *pokemon = self.allPokemon[indexPath.row];
        
        [destinationVC setPokemon:pokemon];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.allPokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Pokemon Cell" forIndexPath:indexPath];
    LSIPokemon *pokemon = self.allPokemon[indexPath.row];
    // Configure the cell...
    
    [cell.textLabel setText: pokemon.name];
    return cell;
}

- (void)setAllPokemon:(NSArray<LSIPokemon *> *)allPokemon {
    if (allPokemon != _allPokemon) {
        _allPokemon = [allPokemon copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}







@end
