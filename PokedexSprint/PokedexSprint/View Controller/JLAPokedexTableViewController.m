//
//  JLAPokedexTableViewController.m
//  PokedexSprint
//
//  Created by Jorge Alvarez on 3/27/20.
//  Copyright © 2020 Jorge Alvarez. All rights reserved.
//

#import "JLAPokedexTableViewController.h"
#import "PokedexSprint-Swift.h"
#import "JLAPokemon.h"
#import "JLADetailViewController.h"

@interface JLAPokedexTableViewController ()

// MARK: - Properties

@property (nonatomic) NSArray<JLAPokemon *> *pokedex;

@end

@implementation JLAPokedexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokemonAPI sharedController] fetchAllPokemonWithCompletion:^(NSArray<JLAPokemon *> *results, NSError *error) {
        
        self.pokedex = results;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokedex.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    JLAPokemon *pokemon = self.pokedex[indexPath.row];
    cell.textLabel.text = [pokemon.name capitalizedString];
    
    return cell;
}

// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        
        JLADetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        
        JLAPokemon *pokemon = self.pokedex[indexPath.row];
        detailVC.pokemon = pokemon;
        [[PokemonAPI sharedController] fillInDetailsFor:pokemon];
    }

}

@end
