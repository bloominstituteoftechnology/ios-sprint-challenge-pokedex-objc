//
//  JDBPokemonTableViewController.m
//  Pokedex
//
//  Created by Madison Waters on 3/15/19.
//  Copyright © 2019 Jonah Bergevin. All rights reserved.
//

#import "JDBPokemonTableViewController.h"
#import "JDBDetailViewController.h"
#import "JDBPokemon.h"
#import "Pokedex-Swift.h"

@interface JDBPokemonTableViewController ()

@property (nonatomic) PokemonAPI *pokemonAPI;
@property (nonatomic, strong) NSArray <JDBPokemon *> *resultsArray;

@end

@implementation JDBPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pokemonAPI = [PokemonAPI sharedController];
    
    [self.pokemonAPI fetchAllPokemonWithCompletion:^(NSArray<JDBPokemon *> *resultsArray, NSError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{
            self.resultsArray = resultsArray;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    JDBPokemon *pokemon = self.resultsArray[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showPokemonDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        JDBDetailViewController *detailVC = [segue destinationViewController];
        detailVC.pokemon = self.resultsArray[indexPath.row];
    }
}


@end
