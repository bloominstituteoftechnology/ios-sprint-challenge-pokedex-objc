//
//  LSIPokemonTableViewController.m
//  Pokedex-ObjC
//
//  Created by Iyin Raphael on 3/15/19.
//  Copyright © 2019 Iyin Raphael. All rights reserved.
//

#import "LSIPokemonTableViewController.h"
#import "LSIPokemon.h"
#import "Pokedex_ObjC-Swift.h"
#import "LSIPokemonViewController.h"

@interface LSIPokemonTableViewController ()

@property PokemonGET *network;
@property NSMutableArray <LSIPokemon *> *pokemons;

@end

@implementation LSIPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.network = [[PokemonGET alloc] init];
    [self.network fetchPokemonWithCompletion:^(NSArray<LSIPokemon *> *list, NSError *error) {
        if (error) {
            NSLog(@"Error fetching data: %@", error);
        }
        self.pokemons = [list mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
     
     
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.pokemons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pokemonCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.pokemons[indexPath.row] name];
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showSegue"]) {
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        LSIPokemonViewController *detailVC = segue.destinationViewController;
        detailVC.pokemon = [self.pokemons objectAtIndex:index.row];
    }
}

@end
