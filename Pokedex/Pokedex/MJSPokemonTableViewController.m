//
//  MJSPokemonTableViewController.m
//  Pokedex
//
//  Created by Michael Stoffer on 11/23/19.
//  Copyright © 2019 Michael Stoffer. All rights reserved.
//

#import "MJSPokemonTableViewController.h"
#import "MJSPokemonDetailViewController.h"
#import "MJSPokemon.h"
#import "Pokedex-Swift.h"

@interface MJSPokemonTableViewController ()

@property (nonatomic) NSArray<MJSPokemon *> *pokemon;

@end

@implementation MJSPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MJSPokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<MJSPokemon *> *pokemon, NSError *error) {
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

    MJSPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        MJSPokemonDetailViewController *detailVC = segue.destinationViewController;
        
        detailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
    }
}

@end
