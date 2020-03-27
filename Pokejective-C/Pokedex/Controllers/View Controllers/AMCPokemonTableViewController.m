//
//  AMCPokemonTableViewController.m
//  Pokedex
//
//  Created by Aaron Cleveland on 3/27/20.
//  Copyright © 2020 Aaron Cleveland. All rights reserved.
//

#import "AMCPokemonTableViewController.h"
#import "AMCPokemonDetailViewController.h"
#import "AMCPokemon.h"
#import "Pokedex-Swift.h"

@interface AMCPokemonTableViewController ()

@property (nonatomic) NSArray<AMCPokemon *> *pokemon;

@end

@implementation AMCPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AMCPokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<AMCPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error returning pokemon: %@", error);
        }
        
        self.pokemon = pokemon;
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];

    AMCPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokemonDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        AMCPokemonDetailViewController *detailVC = segue.destinationViewController;
        
        detailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
    }
}

@end

