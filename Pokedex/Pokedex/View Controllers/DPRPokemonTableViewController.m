//
//  DPRPokemonTableViewController.m
//  Pokedex
//
//  Created by Dennis Rudolph on 1/31/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "DPRPokemonTableViewController.h"
#import "DPRPokemon.h"
#import "Pokedex-Swift.h"

@interface DPRPokemonTableViewController ()

@property NSArray<DPRPokemon *> *fetchedNames;

@end

@implementation DPRPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<DPRPokemon *> * _Nullable array, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error fetching pokemon");
        }
        self.fetchedNames = array;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.fetchedNames objectAtIndex:indexPath.row] name].capitalizedString;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        DPRPokemon *pokemon = [self.fetchedNames objectAtIndex:indexPath.row];
        
        detailVC.pokemon = pokemon;
    }
}


@end
