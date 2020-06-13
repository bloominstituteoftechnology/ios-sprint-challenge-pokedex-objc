//
//  TSAPokemonTableViewController.m
//  Pokedex
//
//  Created by Alex Thompson on 6/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "TSAPokemonTableViewController.h"
#import "Pokedex-Swift.h"
#import "TSAPokemon.h"
#import "TSAPokemonDetailViewController.h"

@interface TSAPokemonTableViewController ()

@property (nonatomic) TSAPokemonController *pokemonController;
@property (nonatomic, copy) NSArray<TSAPokemon *> *pokemon;

@end

@implementation TSAPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.pokemonController fetchAllPokemonWithCompletion:^(NSArray<TSAPokemon *> * _Nullable pokemon, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pokemon.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    TSAPokemon *pokemon = self.pokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"DetailSegue"]) {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        
        TSAPokemonDetailViewController *controller = (TSAPokemonDetailViewController *)segue.destinationViewController;
        controller.pokemonController = self.pokemonController;
        controller.pokemon = self.pokemon[selectedIndexPath.row];}
}

@end
