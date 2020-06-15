//
//  SKIPokemonTableViewController.m
//  SprintChallenge
//
//  Created by Joshua Rutkowski on 6/14/20.
//  Copyright © 2020 Ski. All rights reserved.
//

#import "SKIPokemonTableViewController.h"
#import "SprintChallenge-Swift.h"
#import "SKIPokemon.h"

@interface SKIPokemonTableViewController ()

@property NSArray<SKIPokemon *> *pokemen;

@end

@implementation SKIPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPokemonNames];
}

- (void)loadPokemonNames {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<SKIPokemon *> *pokemonNames, NSError *error) {
        
        if (error) {
            NSLog(@"%@", error);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemen = pokemonNames;
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
return self.pokemen.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.pokemen[indexPath.row].name capitalizedString];
    
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    SKIPokemon *pokemon = self.pokemen[indexPath.row];
    
    [PokemonAPI.sharedController fetchAllDetailsFor:pokemon];
}

@end
