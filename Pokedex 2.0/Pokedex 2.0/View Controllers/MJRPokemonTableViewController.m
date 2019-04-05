//
//  MJRPokemonTableViewController.m
//  Pokedex 2.0
//
//  Created by Moses Robinson on 4/5/19.
//  Copyright © 2019 Moses Robinson. All rights reserved.
//

#import "MJRPokemonTableViewController.h"
#import "Pokedex_2_0-Swift.h"
#import "MJRPokemon.h"

@interface MJRPokemonTableViewController ()

@property (nonatomic) NSArray<MJRPokemon *> *pokedex;

@end

@implementation MJRPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[MJRPokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<MJRPokemon *> * pokedex, NSError * error) {
        
        self.pokedex = pokedex;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self pokedex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    MJRPokemon *pokemon = self.pokedex[indexPath.row];
    
    cell.textLabel.text = pokemon.name.capitalizedString;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        
        // Passing the task and task controller (tapped on a task cell)
        
        PokemonDetailViewController *destination = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        MJRPokemon *pokemon = self.pokedex[indexPath.row];
        
        destination.pokemon = pokemon;
    }
}

@end
