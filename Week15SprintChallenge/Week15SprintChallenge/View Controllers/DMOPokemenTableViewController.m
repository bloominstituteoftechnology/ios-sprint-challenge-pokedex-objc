//
//  DMOPokemenTableViewController.m
//  Week15SprintChallenge
//
//  Created by morse on 1/31/20.
//  Copyright © 2020 morse. All rights reserved.
//

#import "DMOPokemenTableViewController.h"
#import "Week15SprintChallenge-Swift.h"
#import "DMOPokemon.h"

@interface DMOPokemenTableViewController ()

@property NSArray<DMOPokemon *> *pokemen;

@end

@implementation DMOPokemenTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadNames];
}

- (void)loadNames {
    [PokemonAPI.sharedController fetchAllPokemonWithCompletion:^(NSArray<DMOPokemon *> *pokemonNames, NSError *error) {
        
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
    DMOPokemon *pokemon = self.pokemen[indexPath.row];
    
    [PokemonAPI.sharedController fillInDetailsFor:pokemon];
}

@end
