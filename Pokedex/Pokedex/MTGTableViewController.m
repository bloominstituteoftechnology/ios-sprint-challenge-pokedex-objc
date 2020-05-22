//
//  MTGTableViewController.m
//  Pokedex
//
//  Created by Mark Gerrior on 5/22/20.
//  Copyright © 2020 Mark Gerrior. All rights reserved.
//

#import "MTGTableViewController.h"
#import "Pokedex-Swift.h"
#import "MTGPokemon.h"
#import "MTGDetailViewController.h"

@interface MTGTableViewController ()

@property (nonatomic, nonnull) NSArray<MTGPokemon *> *allPokemon;

@end

@implementation MTGTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<MTGPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Error fetching pokemon: %@", error);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.allPokemon[indexPath.row].name;
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[MTGDetailViewController class]]) {
        MTGDetailViewController *detailVC = segue.destinationViewController;

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath) {
            detailVC.pokemon = self.allPokemon[indexPath.row];
        }
    }
}

@end
