//
//  MBPokemonTableViewController.m
//  PokedexObjC
//
//  Created by Mitchell Budge on 7/26/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

#import "MBPokemonTableViewController.h"

@interface MBPokemonTableViewController ()

@end

@implementation MBPokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[MBPokemonController sharedController] fetchAllPokemonWithCompletion:^(NSArray<MBPokemon *> * pokedex, NSError * error) {
        self.allPokemon = self->_allPokemon;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    MBPokemon *pokemon = self.allPokemon[indexPath.row];
    cell.textLabel.text = pokemon.name;
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

@end
