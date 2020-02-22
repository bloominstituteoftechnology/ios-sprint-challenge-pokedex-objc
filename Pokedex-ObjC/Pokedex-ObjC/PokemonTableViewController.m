//
//  PokemonTableViewController.m
//  Pokedex-ObjC
//
//  Created by Fabiola S on 2/22/20.
//  Copyright © 2020 Fabiola Saga. All rights reserved.
//

#import "PokemonTableViewController.h"
#import "PokemonDetailViewController.h"
#import "Pokemon.h"
#import "Pokedex_ObjC-Swift.h"


@interface PokemonTableViewController ()

@property (nonatomic) NSArray<Pokemon *> *pokemon;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [PokemonController.sharedController fetchPokemonWithCompletion:^(NSArray<Pokemon *> * pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching pokemon: %@", error);
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

    Pokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PokemonDetailSegue"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        PokemonDetailViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = [self.pokemon objectAtIndex:indexPath.row];
    }
}


@end
